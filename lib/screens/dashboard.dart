import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/header_bar.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final cards = <_CardData>[
      const _CardData(
        title: 'Assigned Leads',
        value: '12 Leads',
        color: Color(0xFFD9F1FF),
        icon: Icons.shield_outlined,
      ),
      const _CardData(
        title: 'Follow-up Leads',
        value: '5 Due Lead',
        color: Color(0xFFCDF0CF),
        icon: Icons.sticky_note_2_outlined,
      ),
      const _CardData(
        title: 'Contacted Leads',
        value: '9 Leads',
        color: Color(0xAAFFE0B2),
        icon: Icons.content_paste_search_outlined,
      ),
    ];

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Immediately inside the ListView, before the scroll cards:
          // Header row under AppBar: avatar on left, bell on right
          const HeaderBar(),

          const SizedBox(height: 8),

          // Horizontal scroll cards (equal size)
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final d = cards[index];
                return SizedBox(
                  width: 280, // was 260; give more room to avoid overflow
                  child: _StatCard(
                    title: d.title,
                    value: d.value,
                    color: d.color,
                    icon: d.icon,
                    onTap: () {},
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          // "My States" header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.my_location_outlined, color: cs.primary),
                  const SizedBox(width: 8),
                  const Text('My States',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ]),
                const Text('Log in : 9:15 AM',
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Metrics card
          Card(
            elevation: 1.5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            color: const Color(0xFFD9F1FF),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text('Metric',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Value',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  ..._metrics.map((m) => _MetricTile(metric: m)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CardData {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  const _CardData(
      {required this.title,
      required this.value,
      required this.color,
      required this.icon});
}

// 2) Robust _StatCard with wrapping and indentation
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    const iconSize = 24.0;
    const gap = 8.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),

            // Text area flexes to remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon, size: iconSize),
                      const SizedBox(width: gap),
                      // Title expands and may wrap to a second line
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2, // allow wrap instead of overflow
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: text.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Indent value so it sits under the title (leave space under icon)
                  Padding(
                    padding: const EdgeInsets.only(left: iconSize + gap),
                    child: Text(
                      value,
                      maxLines: 2, // allow value to wrap as well
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: text.bodyMedium?.copyWith(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Trailing control keeps its intrinsic width
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(10),
              ),
              icon: const Icon(Icons.arrow_forward, size: 22),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MetricItem {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  const MetricItem(this.icon, this.label, this.value, {this.iconColor});
}

final List<MetricItem> _metrics = [
  MetricItem(Icons.call, 'First Call', '9:45 AM'),
  MetricItem(Icons.call, 'Last Call', '5:00 PM'),
  MetricItem(Icons.call, 'All Calls', '135'),
  MetricItem(Icons.call_received, 'Incoming Calls', '35',
      iconColor: Colors.green),
  MetricItem(Icons.call_made, 'Outgoing Calls', '35', iconColor: Colors.green),
  MetricItem(Icons.call_missed_outgoing, 'Missed Calls', '35',
      iconColor: Colors.red),
  MetricItem(Icons.call_end, 'Connected Calls', '35'),
  MetricItem(Icons.phone_in_talk, 'Attempted Calls', '35'),
  MetricItem(Icons.timer_outlined, 'Total Duration', '20 min'),
];

class _MetricTile extends StatelessWidget {
  final MetricItem metric;
  const _MetricTile({required this.metric});

  static const double _iconSize = 22;
  static const double _gap = 10;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              // LEFT COLUMN (≈60%)
              Expanded(
                flex: 3, // ~60% of the row
                child: Row(
                  children: [
                    Icon(metric.icon,
                        size: _iconSize,
                        color: metric.iconColor ?? Colors.black87),
                    const SizedBox(width: _gap),
                    Expanded(
                      child: Text(
                        metric.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),

              // RIGHT COLUMN (≈40%) aligned right
              Expanded(
                flex: 2, // ~40% of the row
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    metric.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        text.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
