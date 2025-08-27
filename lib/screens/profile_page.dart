import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/header_bar.dart';

class ProfilePageScreen extends StatefulWidget {
  static const route = '/profile_page';
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool autoDial = false;
  String followUp = 'Default 15 min';

  final reminderOptions = <String>[
    'Default 15 min',
    '5 min',
    '10 min',
    '30 min',
    '1 hour',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        actions: const [
          // X button on the right
          CloseButton(), // calls Navigator.maybePop() by default
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        toolbarHeight: 56, // default; adjust if needed
        elevation: 0,      // flat like screenshot
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const HeaderBar(),
              const SizedBox(
                height: 20,
              ),
              _ProfileCard(
                nameCtrl: nameCtrl,
                emailCtrl: emailCtrl,
                passCtrl: passCtrl,
              ),
              const SizedBox(height: 16),
              _CallSettingCard(
                autoDial: autoDial,
                onToggle: (v) => setState(() => autoDial = v),
                followUpValue: followUp,
                reminderOptions: reminderOptions,
                onFollowUpChanged: (v) => setState(() => followUp = v!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color(0xFFE1F3FF); // light blue like screenshot
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with title and avatar
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.person_outline),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleWithIcon(title: 'Profile'),
                    SizedBox(height: 4),
                    Text(
                      'Your personal info and security',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _EditBadge(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _LabeledInput(label: 'Full Name', controller: nameCtrl),
          const SizedBox(height: 12),
          _LabeledInput(
              label: 'Email',
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _LabeledInput(
              label: 'Password', controller: passCtrl, obscureText: true),
        ],
      ),
    );
  }
}

class _CallSettingCard extends StatelessWidget {
  const _CallSettingCard({
    required this.autoDial,
    required this.onToggle,
    required this.followUpValue,
    required this.reminderOptions,
    required this.onFollowUpChanged,
  });

  final bool autoDial;
  final ValueChanged<bool> onToggle;
  final String followUpValue;
  final List<String> reminderOptions;
  final ValueChanged<String?> onFollowUpChanged;

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color(0xFFE7F8EA);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 30, 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              _TitleWithIcon(title: 'Call Setting', icon: Icons.call),
              Spacer(),
              _SaveBadge(),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left labels - heavier weight
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable Auto-dial',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Follow-up Reminder',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Right controls - keep constrained dropdown
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Switch.adaptive(
                        value: autoDial,
                        onChanged: onToggle,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 180, // <-- set desired width here
                        child: DropdownButtonFormField<String>(
                          value: followUpValue,
                          items: reminderOptions
                              .map<DropdownMenuItem<String>>((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: onFollowUpChanged,
                          isExpanded: false, // don’t fill parent
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border.copyWith(
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: const _EditIcon(),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
                borderSide: const BorderSide(color: Colors.black)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}

class _EditIcon extends StatelessWidget {
  const _EditIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: const Icon(Icons.edit, size: 16, color: Colors.white),
      ),
    );
  }
}

class _EditBadge extends StatelessWidget {
  const _EditBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: const Icon(Icons.edit, size: 16, color: Colors.white),
    );
  }
}

class _SaveBadge extends StatelessWidget {
  const _SaveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: const Icon(Icons.save_outlined, size: 30, color: Colors.black87),
    );
  }
}

class _TitleWithIcon extends StatelessWidget {
  const _TitleWithIcon({required this.title, this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 6),
        ],
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
