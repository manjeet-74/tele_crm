import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeadDetailsScreen extends StatelessWidget {
  static const route = '/lead-details';

  final String leadId;
  final String name;
  final String phone;
  final String status;

  const LeadDetailsScreen({
    super.key,
    required this.leadId,
    required this.name,
    required this.phone,
    required this.status,
  });

  // Helper: construct from Navigator settings if using onGenerateRoute
  static LeadDetailsScreen fromArgs(RouteSettings s) {
    final id = (s.arguments as String?) ?? 'LD-0000';
    return LeadDetailsScreen(
      leadId: id,
      name: 'Name',
      phone: '+91-564646454',
      status: 'Fresh',
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Mock details; wire to real data later
    final details = {
      'email': 'abc_123@gmail.com',
      'phone': '+91-554555454',
      'altPhone': '+91- Enter Phone Number',
      'address': 'Empty',
      'state': 'Empty',
      'url': 'www.dsdsdasd.com',
      'newUrl': 'www.dsdsdasd.com',
      'status': 'Fresh',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('All Leads'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded),
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ), // AppBar per Material guidance [5]

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // Top info card with light blue outline
          _LeadInfoCard(
            name: name,
            details: details,
          ), // Card is the canonical way to group related info [3][4]

          const SizedBox(height: 12),

          // Actions toolbar row (Call, Call Later, WhatsApp, SMS, Notes)
          _ActionsToolbar(
            onCall: () {},
            onCallLater: () {},
            onWhatsapp: () {},
            onSms: () {},
            onNotes: () {},
          ), // Uses Ink+Icon for Material feedback [3][4]

          const SizedBox(height: 16),

          // History header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              // Filter row: All Actions, Time, Team as filled-tonal chips/buttons
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _FilterChipTonal(label: 'All Actions'),
                  _FilterChipTonal(label: 'Time'),
                  _FilterChipTonal(label: 'Team'),
                ],
              ), // Chip is compact for filters, mirroring the mock [6]

              const SizedBox(height: 12),
            ]),
          ),

          // History list items
          // ...List.generate(8, (i) {
          //   final isImportant = i % 3 == 0;
          //   return _HistoryTile(
          //     title: i % 2 == 0 ? 'Bana knsns' : 'Os',
          //     subtitle: i % 2 == 0
          //         ? 'Lead Reassigned from Vivek'
          //         : 'Feedback not added',
          //     leadingIcon: i % 2 == 0 ? Icons.assignment_return : Icons.call,
          //     starred: i == 0 || i == 1,
          //     timeText: '12s',
          //     badgeText: 'V',
          //     highlight: isImportant,
          //   );
          // }), // Simple list of tiles with slim separators [3][4]
          const _HistoryTile(
              leadingIcon: Icons.assignment_return,
              subleadingIcon: CupertinoIcons.star,
              personIcon: CupertinoIcons.person,
              title: 'BAna knsns',
              subtitle: 'Lead Reassigned from Vivek',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.assignment_return,
              subleadingIcon: CupertinoIcons.star,
              personIcon: CupertinoIcons.person,
              title: 'BAna knsns',
              subtitle: 'Lead Reassigned from Vivek',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
          const _HistoryTile(
              leadingIcon: Icons.call,
              subleadingIcon: Icons.sim_card_outlined,
              title: '0s',
              subtitle: 'Feedback not added',
              starred: false,
              timeText: '12s',
              badgeText: 'V',
              highlight: true),
        ],
      ),
    );
  }
}

class _LeadInfoCard extends StatelessWidget {
  final String name;
  final Map<String, String> details;

  const _LeadInfoCard({
    required this.name,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    const borderBlue = Color(0xFFBFE9FF);
    const chipBlue = Color(0xFFD9F1FF);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderBlue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name row + trailing menu
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),

            // Status + stars row
            Row(
              children: [
                Chip(
                  label: const Text(
                    'Fresh',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: chipBlue,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ), // Status pill mirrors compact Chip in mock [6]
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (i) => Padding(
                    padding: EdgeInsets.only(right: i == 4 ? 0 : 4),
                    child: const Icon(
                      Icons.star_border_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

// NEW: divider between header and details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 6),

            // Key-value lines with icons, light separators similar to screenshot
            _kv(Icons.email_outlined, 'Email', details['email'] ?? '—'),
            _kv(Icons.phone_outlined, 'Phone', details['phone'] ?? '—'),
            _kv(Icons.phone_in_talk_outlined, 'Alternate phone',
                details['altPhone'] ?? '—',
                hintStyle: true),
            _kv(Icons.place_outlined, 'Address', details['address'] ?? '—'),
            _kv(Icons.map_outlined, 'State', details['state'] ?? '—'),
            _kv(Icons.link_outlined, 'URL', details['url'] ?? '—'),
            _kv(Icons.link_rounded, 'New URL', details['newUrl'] ?? '—'),
          ],
        ),
      ),
    );
  }

  Widget _kv(IconData? icon, String label, String value,
      {bool indentText = false, bool hintStyle = false}) {
    const labelStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.25,
    );

    final valueStyle = TextStyle(
      color: hintStyle ? Colors.grey.shade500 : Colors.black87,
      fontSize: hintStyle ? 12 : 14,
      height: 1.3,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || label.isNotEmpty)
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.grey.shade700),
                const SizedBox(width: 6)
              ],
              if (label.isNotEmpty)
                Text(
                  label,
                  style: labelStyle,
                ),
            ]),
          Text(
            value,
            style: valueStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ActionsToolbar extends StatelessWidget {
  final VoidCallback onCall;
  final VoidCallback onCallLater;
  final VoidCallback onWhatsapp;
  final VoidCallback onSms;
  final VoidCallback onNotes;

  const _ActionsToolbar({
    required this.onCall,
    required this.onCallLater,
    required this.onWhatsapp,
    required this.onSms,
    required this.onNotes,
  });

  @override
  Widget build(BuildContext context) {
    final tileBg = const Color(0xFFD9F1FF);

    Widget action(IconData icon, String label, VoidCallback onTap) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 22, color: Colors.black87),
                  const SizedBox(height: 4),
                  Text(label, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Ink(
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            action(Icons.call_outlined, 'Call', onCall),
            action(Icons.schedule_outlined, 'Call Later', onCallLater),
            action(Icons.whatshot, 'WhatsApp', onWhatsapp),
            action(Icons.sms_outlined, 'SMS', onSms),
            action(Icons.note_alt_outlined, 'Notes', onNotes),
          ],
        ),
      ),
    );
  }
}

class _FilterChipTonal extends StatelessWidget {
  final String label;
  const _FilterChipTonal({required this.label});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.grey.shade300, // grey pill bg
        foregroundColor: Colors.black87, // text & icon color
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    ); // Matches “All Actions/Time/Team” compact selectors [6]
  }
}

class _HistoryTile extends StatelessWidget {
  final IconData leadingIcon;
  final IconData subleadingIcon;
  final IconData? personIcon;
  final String title;
  final String subtitle;
  final bool starred;
  final String timeText;
  final String badgeText;
  final bool highlight;

  const _HistoryTile(
      {required this.leadingIcon,
      required this.title,
      required this.subtitle,
      required this.starred,
      required this.timeText,
      required this.badgeText,
      required this.highlight,
      required this.subleadingIcon,
      this.personIcon});

  @override
  Widget build(BuildContext context) {
    final dividerColor = const Color(0xFFD9F1FF);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(children: [
                    Icon(starred ? Icons.star : Icons.star_border, size: 18),
                    if (personIcon != null)
                      Icon(
                        personIcon,
                        size: 18,
                      )
                  ]),
                  const SizedBox(width: 6),
                  Column(children: [
                    Icon(leadingIcon, size: 18),
                    Icon(
                      subleadingIcon,
                      size: 18,
                    )
                  ]),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and trailing cluster
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(timeText, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 10),
                  _SmallBadge(text: badgeText),
                ],
              )
            ],
          ),
        ),
        // Thin divider like the blue line in the mock
        Container(
          height: 4,
          margin: const EdgeInsets.only(left: 24),
          decoration: BoxDecoration(
            color: dividerColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ); // Simple list item built from Rows per layout guide [4][3]
  }
}

class _SmallBadge extends StatelessWidget {
  final String text;
  const _SmallBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFD9F1FF),
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
