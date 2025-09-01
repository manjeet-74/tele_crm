import 'package:flutter/material.dart';
import 'package:sim_data/sim_data.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart'; // Android only [10]
import 'package:tele_crm/constants.dart';

class SimCardManagerPage extends StatefulWidget {
  static const route = '/sim_card_manager';
  const SimCardManagerPage({super.key});

  @override
  State<SimCardManagerPage> createState() => _SimCardManagerPageState();
}

class _SimCardManagerPageState extends State<SimCardManagerPage> {
  List<SimCard> _cards = [];
  bool _loading = true;
  String _syncChoice = 'Sync TeleCRM Calls';

  @override
  void initState() {
    super.initState();
    _loadSims();
  }

  Future<void> _loadSims() async {
    try {
      final data = await SimDataPlugin.getSimData(); // requires permission [10]
      setState(() {
        _cards = data.cards;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Sim Card Manager'),
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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: ListView(
                children: [
                  _SimSection(
                    indexBadge: '1',
                    title: _cards.isNotEmpty
                        ? (_cards.first.carrierName.isNotEmpty == true
                            ? _cards.first.carrierName
                            : 'SIM ${(_cards.first.slotIndex ?? 0) + 1}')
                        : 'Jio 4G',
                    trailing: _SyncDropdown(
                      value: _syncChoice,
                      onChanged: (v) => setState(() => _syncChoice = v),
                    ),
                    lastCallNumber: '+91-564646454',
                    lastCallDate: '25/05/2025',
                    lastCallTime: '10:51 AM',
                  ), // Card styling mirrors ListTile-in-Card/Material with elevation. [7][11]
                  const SizedBox(height: 16),
                  _SimSection(
                    indexBadge: '2',
                    title: _cards.length > 1
                        ? (_cards[1].carrierName.isNotEmpty == true
                            ? _cards[1].carrierName
                            : 'SIM ${(_cards[1].slotIndex ?? 1) + 1}')
                        : 'Airtel',
                    lastCallNumber: '+91-564646454',
                    lastCallDate: '25/05/2025',
                    lastCallTime: '10:51 AM',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Check your blocklist',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      backgroundColor: cs.surface,
    );
  }
}


class _SyncDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _SyncDropdown({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: BorderSide(color: cs.outlineVariant),
        foregroundColor: Colors.black87,
        backgroundColor: selectedFill,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _showSyncSheet(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        ],
      ),
    );
  }

  Future<void> _showSyncSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ), // Rounded corners for the modal. [11][8]
      builder: (ctx) {
        return _SyncOptionsSheet(current: value);
      },
    ); // Standard API for custom bottom sheets. [10]

    if (selected != null && selected != value) {
      onChanged(selected);
    }
  }
}

class _SyncOptionsSheet extends StatelessWidget {
  const _SyncOptionsSheet({required this.current});
  final String current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    Widget option({
      required String title,
      required String subtitle,
      required String value,
      bool selected = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => Navigator.of(context).pop(value),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
              color: selected ? selectedFill : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(subtitle,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.black87)),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: blueBg,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            option(
              title: 'Sync TeleCRM Calls',
              subtitle: 'Only leads present in CRM will be synced',
              value: 'Sync TeleCRM Calls',
              selected: current == 'Sync TeleCRM Calls',
            ),
            const SizedBox(height: 14),
            option(
              title: 'Sync all Calls',
              subtitle: 'All calls will be synced',
              value: 'Sync all Calls',
              selected: current == 'Sync all Calls',
            ),
            const SizedBox(height: 14),
            option(
              title: "Don't sync",
              subtitle: 'No calls will be synced',
              value: "Don't sync",
              selected: current == "Don't sync",
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SimSection extends StatelessWidget {
  final String indexBadge;
  final String title;
  final Widget? trailing;
  final String lastCallNumber;
  final String lastCallDate;
  final String lastCallTime;

  const _SimSection({
    required this.indexBadge,
    required this.title,
    this.trailing,
    required this.lastCallNumber,
    required this.lastCallDate,
    required this.lastCallTime,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surface,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Badge(number: indexBadge),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 12),
          Material(
            elevation: 0,
            color: cs.surface,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBFE9FF)),
              ), // Rounded border around the “Last call” tile. [11]
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last call',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          children: [
                            Text(lastCallNumber),
                            Text('|'),
                            Text(lastCallDate),
                            Text('|'),
                            Text(lastCallTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String number;
  const _Badge({required this.number});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(number,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
