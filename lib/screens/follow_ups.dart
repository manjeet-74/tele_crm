import 'package:flutter/material.dart';
import 'package:tele_crm/components/header_bar.dart'; // zero-arg header we made

class FollowUpsScreen extends StatelessWidget {
  static const route = '/follow-ups';

  const FollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Fake data
    final items = List.generate(
        4,
        (_) => const _FollowUp(
              name: 'Name',
              phone: '+91 555325256',
              dateTime: '24 May, 11:45 AM',
              status: 'Fresh',
            ));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Follow-ups'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header row: rounded rect avatar + bell
          const HeaderBar(),

          const SizedBox(height: 12),

          ...items.map((m) => _FollowUpCard(m: m, cs: cs)),
          const SizedBox(height: 16),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _FollowUp {
  final String name;
  final String phone;
  final String dateTime;
  final String status;
  const _FollowUp({
    required this.name,
    required this.phone,
    required this.dateTime,
    required this.status,
  });
}

class _FollowUpCard extends StatelessWidget {
  final _FollowUp m;
  final ColorScheme cs;
  const _FollowUpCard({required this.m, required this.cs});

  @override
  Widget build(BuildContext context) {
    const border = Color(0xFFBFE9FF);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 18),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: border, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(m.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),

            const SizedBox(height: 6),

            // phone + dot + date
            Row(
              children: [
                Text(m.phone, style: const TextStyle(color: Colors.black87)),
                const SizedBox(width: 8),
                const _Dot(),
                const SizedBox(width: 8),
                Text(m.dateTime, style: const TextStyle(color: Colors.black87)),
              ],
            ),

            const SizedBox(height: 12),

            // Status label + dropdown-looking chip
            Row(
              children: [
                const Text('Status:', style: TextStyle(color: Colors.black87)),
                const SizedBox(width: 8),
                _StatusExpansion(
                  initial: m.status,
                  onSelected: (v) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Status: $v')),
                    );
                  },
                ),
              ],
            ),



            const SizedBox(height: 12),

            // Action pills in a Wrap so they reflow if space is tight
            const Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _ActionPill(icon: Icons.call, label: 'Call'),
                _ActionPill(icon: Icons.whatshot, label: 'WhatsApp'),
                _ActionPill(icon: Icons.sms_outlined, label: 'SMS'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration:
          const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
    );
  }
}

class _StatusExpansion extends StatefulWidget {
  final String initial;
  final ValueChanged<String> onSelected;
  const _StatusExpansion({required this.initial, required this.onSelected});

  @override
  State<_StatusExpansion> createState() => _StatusExpansionState();
}

class _StatusExpansionState extends State<_StatusExpansion> {
  static const _chipBg = Color(0xFFD9F1FF);
  static const List<String> _options = [
    'Fresh',
    'Not Connected',
    'Interested',
    'Committed',
    'Call Back',
    'Not Interested',
    'Won',
    'Lost',
    'Temple Visit',
    'Temple Donar',
  ];

  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
  }

  void _toggleOverlay() {
    if (_entry != null) {
      _removeOverlay();
      return;
    }

    final overlay = Overlay.of(context);
    // if (overlay == null) return;

    _entry = OverlayEntry(
      builder: (context) {
        // Use CompositedTransformFollower to position the panel
        return Stack(
          children: [
            // Tap outside to dismiss
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeOverlay,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: const Offset(0, 40), // panel below the pill
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 220,
                  height: 320,
                  child: _StatusPanel(
                    options: _options,
                    onPicked: (s) {
                      setState(() => _value = s);
                      widget.onSelected(s);
                      _removeOverlay();
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_entry!);
  }

  @override
  Widget build(BuildContext context) {
    // The anchor pill
    return CompositedTransformTarget(
      link: _link,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: _toggleOverlay,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _chipBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_value, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_drop_down_rounded, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String> onPicked;
  const _StatusPanel({required this.options, required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          shrinkWrap: true,
          itemCount: options.length,
          separatorBuilder: (_, __) => const Divider(height: 0, color: Color(0xFFE6E6E6)),
          itemBuilder: (context, i) {
            final s = options[i];
            return ListTile(
              dense: true,
              title: Text(s),
              onTap: () => onPicked(s),
            );
          },
        ),
      ),
    );
  }
}





class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: const Color(0xFFD9F1FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
