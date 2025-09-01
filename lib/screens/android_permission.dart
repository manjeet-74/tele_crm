import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; // requests + checks [2]
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';
import 'package:url_launcher/url_launcher.dart'; // for overlay settings deep-link

class AndroidPermissionsPage extends StatefulWidget {
  static const route = 'android-permission';
  const AndroidPermissionsPage({super.key});

  @override
  State<AndroidPermissionsPage> createState() => _AndroidPermissionsPageState();
}

class _AndroidPermissionsPageState extends State<AndroidPermissionsPage> {
  bool _callLog = false;
  bool _contacts = false;
  bool _phone = false;
  bool _overlay = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _refreshStatuses();
  }

  Future<void> _refreshStatuses() async {
    if (!Platform.isAndroid) {
      setState(() {
        _loading = false;
      });
      return;
    }
    final callLog = await Permission.phone.isGranted; // requires call_log on Android 16+ as separate perm
    final contacts = await Permission.contacts.isGranted;
    final phone = await Permission.phone.isGranted;
    final overlay = await _canDrawOverlays();
    setState(() {
      _callLog = callLog;
      _contacts = contacts;
      _phone = phone;
      _overlay = overlay;
      _loading = false;
    });
  }

  // Overlay (draw over other apps) is a special Settings toggle; handle via intent. [10]
  Future<bool> _canDrawOverlays() async {
    // permission_handler exposes Permission.systemAlertWindow on some versions,
    // but robust approach is to query platform Settings via intent deep link.
    // Here we rely on package method if available; else assume false.
    final status =
        await Permission.systemAlertWindow.status; // supported by plugin [2]
    return status.isGranted;
  }

  Future<void> _requestCallLog(bool value) async {
    if (!value) {
      // Cannot revoke programmatically; open settings. [3]
      await openAppSettings();
      await _refreshStatuses();
      return;
    }
    final ph = await Permission.phone.request();
    final log = await Permission.phone.request();
    if (ph.isPermanentlyDenied || log.isPermanentlyDenied) {
      await openAppSettings(); // navigate to app settings if locked [3][5]
    }
    await _refreshStatuses();
  }

  Future<void> _requestContacts(bool value) async {
    if (!value) {
      await openAppSettings(); // user must revoke manually [3]
      await _refreshStatuses();
      return;
    }
    final res = await Permission.contacts.request();
    if (res.isPermanentlyDenied) {
      await openAppSettings(); // open Settings if needed [3]
    }
    await _refreshStatuses();
  }

  Future<void> _requestPhone(bool value) async {
    if (!value) {
      await openAppSettings();
      await _refreshStatuses();
      return;
    }
    final res = await Permission.phone.request();
    if (res.isPermanentlyDenied) {
      await openAppSettings(); // [3]
    }
    await _refreshStatuses();
  }

  Future<void> _requestOverlay(bool value) async {
    if (!value) {
      await openAppSettings();
      await _refreshStatuses();
      return;
    }
    // permission_handler exposes systemAlertWindow.request on Android. [2]
    final res = await Permission.systemAlertWindow.request();
    if (res.isPermanentlyDenied || !res.isGranted) {
      // Fallback: deep-link to overlay settings screen. [10]
      final uri = Uri.parse('package:'); // placeholder, see below util
      await _openOverlaySettings();
    }
    await _refreshStatuses();
  }

  Future<void> _openOverlaySettings() async {
    // Deep link to overlay settings page for this package. [10]
    final pkg = await _packageName();
    final uri = Uri.parse('package:$pkg');
    final overlayUri = Uri(
        scheme: 'android.settings',
        host: 'action',
        path:
            'MANAGE_OVERLAY_PERMISSION'); // not launchable with url_launcher directly; use intent scheme
    final intentUri = Uri.parse(
        'intent:#Intent;action=android.settings.action.MANAGE_OVERLAY_PERMISSION;S.package=$pkg;end');
    try {
      await launchUrl(intentUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      await openAppSettings(); // fallback [3]
    }
  }

  Future<String> _packageName() async {
    // Use package_info_plus if you want the real package name.
    return 'com.example.app';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Android Permissions'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          NotificationBell(
            onPressed: () {},
            showBadge: true,
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black87,
            size: 22,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      "Manage your app’s android permissions",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6F3FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        PermissionTile(
                          icon: Icons.receipt_long_outlined,
                          title: 'Read call logs',
                          subtitle:
                              'Allow reading call history for syncing calls',
                          value: _callLog,
                          onChanged: _requestCallLog,
                        ),
                        const SizedBox(height: 12),
                        PermissionTile(
                          icon: Icons.contacts_outlined,
                          title: 'Read contacts',
                          subtitle: 'Allow reading contacts to match CRM leads',
                          value: _contacts,
                          onChanged: _requestContacts,
                        ),
                        const SizedBox(height: 12),
                        PermissionTile(
                          icon: Icons.phone_outlined,
                          title: 'Manage phone calls',
                          subtitle: 'Allow phone access for call management',
                          value: _phone,
                          onChanged: _requestPhone,
                        ),
                        const SizedBox(height: 12),
                        PermissionTile(
                          icon: Icons.display_settings_outlined,
                          title: 'Display over other app',
                          subtitle:
                              'Permit overlays for call popups and widgets',
                          value: _overlay,
                          onChanged: _requestOverlay,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const PermissionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black54)),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: (v) => onChanged(v),
            ),
          ],
        ),
      ),
    );
  }
}
