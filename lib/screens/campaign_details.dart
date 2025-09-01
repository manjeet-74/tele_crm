import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampaignDetailsScreen extends StatelessWidget {
  static const route = '/campaign-details';

  final String leadId;
  final String name;
  final String phone;
  final String status;

  const CampaignDetailsScreen({
    super.key,
    required this.leadId,
    required this.name,
    required this.phone,
    required this.status,
  });

  // Helper: construct from Navigator settings if using onGenerateRoute
  static CampaignDetailsScreen fromArgs(RouteSettings s) {
    final id = (s.arguments as String?) ?? 'LD-0000';
    return CampaignDetailsScreen(
      leadId: id,
      name: 'Name',
      phone: '+91-564646454',
      status: 'Fresh',
    );
  }

  @override
  Widget build(BuildContext context) {
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Campaign'),
        centerTitle: true,
        actions: [
          IconButton.filled(
            style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(10)),
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
          _FollowUpCard(),

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
      {bool hintStyle = false}) {
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
  final int selectedIndex; // 0..4

  const _ActionsToolbar({
    required this.onCall,
    required this.onCallLater,
    required this.onWhatsapp,
    required this.onSms,
    required this.onNotes,
    this.selectedIndex = 1, // highlight "Call Later" as in the screenshot
  });

  @override
  Widget build(BuildContext context) {
    const tileBg = Color(0xFFD9F1FF);

    Widget item({
      required int index,
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      final selected = index == selectedIndex;
      final textStyle = TextStyle(
        fontSize: 14,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        color: Colors.black87,
      );
      return Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28, color: Colors.black87),
                const SizedBox(height: 6),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(label, style: textStyle),
                    ),
                    if (selected)
                      Container(
                        height: 3,
                        width: 68,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return TabularRow(
        tileBg: tileBg,
        onCall: onCall,
        onCallLater: onCallLater,
        onWhatsapp: onWhatsapp,
        onSms: onSms,
        onNotes: onNotes);
  }
}

class TabularRow extends StatefulWidget {
  const TabularRow({
    super.key,
    required this.tileBg,
    required this.onCall,
    required this.onCallLater,
    required this.onWhatsapp,
    required this.onSms,
    required this.onNotes,
  });

  final Color tileBg;
  final VoidCallback onCall;
  final VoidCallback onCallLater;
  final VoidCallback onWhatsapp;
  final VoidCallback onSms;
  final VoidCallback onNotes;

  @override
  State<TabularRow> createState() => _TabularRowState();
}

class _TabularRowState extends State<TabularRow>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tab = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.tileBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: TabBar(
        controller: _tab,
        isScrollable: false,
        labelPadding: EdgeInsets.zero,
        labelColor: const Color(0xFF0E63FF),
        unselectedLabelColor: Colors.black87,
        indicatorColor: const Color(0xFF0E63FF),
        indicatorWeight: 1.0,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_callback_outlined), // WhatsApp icon
                SizedBox(width: 8),
                Text('Call'),
              ],
            ),
          ),
          // item(
          //     index: 0,
          //     icon: Icons.call_outlined,
          //     label: 'Call',
          //     onTap: widget.onCall),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule_outlined), // WhatsApp icon
                SizedBox(width: 8),
                Text('Call Later'),
              ],
            ),
          ),
          // item(
          //     index: 1,
          //     icon: Icons.schedule_outlined,
          //     label: 'Call Later',
          //     onTap: widget.onCallLater),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.chat_bubble_text), // WhatsApp icon
                SizedBox(width: 8),
                Text('Whatsapp'),
              ],
            ),
          ),
          // item(
          //     index: 2,
          //     icon: CupertinoIcons.chat_bubble_text,
          //     label: 'WhatsApp',
          //     onTap: widget.onWhatsapp),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sms_outlined), // WhatsApp icon
                SizedBox(width: 8),
                Text('SMS'),
              ],
            ),
          ),
          // item(
          //     index: 3,
          //     icon: Icons.sms_outlined,
          //     label: 'SMS',
          //     onTap: widget.onSms),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.note_alt_outlined), // WhatsApp icon
                SizedBox(width: 8),
                Text('Notes'),
              ],
            ),
          ),
          // item(
          //     index: 4,
          //     icon: Icons.note_alt_outlined,
          //     label: 'Notes',
          //     onTap: widget.onNotes),
        ],
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
    const dividerColor = Color(0xFFD9F1FF);

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

class _FollowUpCard extends StatelessWidget {
  const _FollowUpCard();

  @override
  Widget build(BuildContext context) {
    const borderBlue = Color(0xFFBFE9FF);
    final lightChip = Colors.grey.shade200;
    final linkColor = const Color(0xFF0B57D0);

    Widget pillButton(String label, {IconData? trailing, VoidCallback? onTap}) {
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: lightChip,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.black87)),
              if (trailing != null) ...[
                Icon(trailing, color: Colors.black87),
              ],
            ],
          ),
        ),
      );
    }

    InputDecoration customInline({
      required String labelText,
      required String hint,
      required VoidCallback onCalendar,
    }) {
      return InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            '$labelText ',
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black87),
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        suffixIcon: IconButton(
          onPressed: onCalendar,
          icon: const Icon(Icons.calendar_today_outlined),
          color: Colors.black87,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.black87, width: 1),
        ),
      );
    }

    void _openCalendar() {
      // wire calendar picker here
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderBlue, width: 2),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title row
          Row(
            children: [
              const Text(
                'Create follow-up for:',
              ),
              const SizedBox(width: 10),
              _PillDropdown<String>(
                initialValue: 'Me',
                items: const [
                  DropdownMenuItem(value: 'Me', child: Text('Me')),
                  DropdownMenuItem(value: 'Team', child: Text('Team')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (v) {
                  // TODO: handle selection
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // quick durations
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              pillButton('In 20 min'),
              pillButton('In 30 min'),
              pillButton('In 1 hour'),
              _PillDropdown<String>(
                initialValue: 'Custom',
                items: const [
                  DropdownMenuItem(value: 'Custom', child: Text('Custom')),
                  DropdownMenuItem(value: 'Today', child: Text('Today')),
                  DropdownMenuItem(value: 'Tomorrow', child: Text('Tomorrow')),
                  DropdownMenuItem(
                      value: 'Next Week', child: Text('Next Week')),
                ],
                onChanged: (v) {
                  // TODO: handle quick preset; optionally open the calendar if 'Custom'
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // custom inline field
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: TextField(
              decoration: customInline(
                labelText: 'Custom:',
                hint: 'DD/MM/YYYY   hh:mm a',
                onCalendar: _openCalendar,
              ).copyWith(
                // add or override inner paddings here
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onTap: _openCalendar,
            ),
          ),
          const SizedBox(height: 12),
          // cancel link
          GestureDetector(
            onTap: () {},
            child: Text(
              'Cancel',
              style: TextStyle(
                color: linkColor,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: linkColor,
                decorationThickness: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T initialValue;
  final ValueChanged<T?>? onChanged;
  final double horizontalPadding;

  const _PillDropdown({
    required this.items,
    required this.initialValue,
    this.onChanged,
    this.horizontalPadding = 14,
  });

  @override
  State<_PillDropdown<T>> createState() => _PillDropdownState<T>();
}

class _PillDropdownState<T> extends State<_PillDropdown<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.grey.shade200;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _value,
          isDense: true,
          onChanged: (v) {
            if (v == null) return;
            setState(() => _value = v);
            widget.onChanged?.call(v);
          },
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
          style: const TextStyle(color: Colors.black87, fontSize: 12),
          items: widget.items,
        ),
      ),
    );
  }
}
