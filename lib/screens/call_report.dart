import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/create_filter_card.dart';
import 'package:tele_crm/components/filter_bar.dart';
import 'package:tele_crm/components/notification_bell.dart';

class CallReportPage extends StatefulWidget {
  static const route = 'call-report';
  const CallReportPage({super.key});

  @override
  State<CallReportPage> createState() => _CallReportPageState();
}

class _CallReportPageState extends State<CallReportPage> {
  // Filters
  String? _leadStatus; // Fresh, Warm, Hot, Closed...
  String? _createdOn; // Today, This week, Custom...
  String? _assignee; // Unassigned, Me, Team...

  final List<String> leadStatuses = const ['Fresh', 'Warm', 'Hot', 'Closed'];
  final List<String> createdOnOptions = const [
    'Today',
    'Yesterday',
    '7 days',
    '30 days'
  ];
  final List<String> assignees = const ['Anyone', 'Me', 'Team A', 'Team B'];

  // Fake data
  late List<CallItem> all;
  List<CallItem> filtered = [];

  @override
  void initState() {
    super.initState();
    all = List.generate(
      30,
      (i) => CallItem(
        name: 'TAPASWINI',
        phone: '2833484883',
        status: 'Fresh',
        createdOn: DateTime.now().subtract(Duration(days: i % 6)),
        assignee: i % 3 == 0 ? 'Me' : 'Anyone',
      ),
    );
    filtered = List.of(all);
  }

  void _applyFilters() {
    setState(() {
      filtered = all.where((c) {
        final byStatus = _leadStatus == null || c.status == _leadStatus;
        final byAssignee = _assignee == null ||
            (_assignee == 'Anyone' ? true : c.assignee == _assignee);
        final byCreated = () {
          if (_createdOn == null) return true;
          final now = DateTime.now();
          final d = c.createdOn;
          switch (_createdOn) {
            case 'Today':
              return d.year == now.year &&
                  d.month == now.month &&
                  d.day == now.day;
            case 'Yesterday':
              final y = now.subtract(const Duration(days: 1));
              return d.year == y.year && d.month == y.month && d.day == y.day;
            case '7 days':
              return d.isAfter(now.subtract(const Duration(days: 7)));
            case '30 days':
              return d.isAfter(now.subtract(const Duration(days: 30)));
            default:
              return true;
          }
        }();
        return byStatus && byAssignee && byCreated;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Call Report',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
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
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CreateFilterCard(),
                SizedBox(
                  height: 18,
                )
              ],
            ),
            // Top of Column, after the "+ Create Filter" button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterBar(
                    leadStatus: _leadStatus, // control = lead status
                    createdOn: _createdOn, // passthrough state
                    assignee: _assignee, // passthrough state
                    leadStatuses: leadStatuses,
                    createdOnOptions: const [], // hide these menus
                    assignees: const [], // hide these menus
                    onChanged: (ls, _co, _as) {
                      // update only status
                      _leadStatus = ls;
                      _applyFilters();
                    },
                  ),
                  FilterBar(
                    leadStatus: _leadStatus,
                    createdOn: _createdOn, // control = createdOn
                    assignee: _assignee,
                    leadStatuses: const [], // hide status menu
                    createdOnOptions: createdOnOptions,
                    assignees: const [], // hide assignee menu
                    onChanged: (_ls, co, _as) {
                      _createdOn = co;
                      _applyFilters();
                    },
                  ),
                  FilterBar(
                    leadStatus: _leadStatus,
                    createdOn: _createdOn,
                    assignee: _assignee, // control = assignee
                    leadStatuses: const [],
                    createdOnOptions: const [],
                    assignees: assignees,
                    onChanged: (_ls, _co, asg) {
                      _assignee = asg;
                      _applyFilters();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 24,
                  thickness: 3,
                  color: Color(0xFFBFE9FF),
                ),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  return _CallRow(
                    item: item,
                    onToggleStar: () =>
                        setState(() => item.starred = !item.starred),
                  );
                },
              ),
            ), // SliverList could be used with SliverAppBar for pinned headers. [8]
          ],
        ),
      ),
    );
  }
}

class _CallRow extends StatelessWidget {
  const _CallRow({required this.item, required this.onToggleStar});

  final CallItem item;
  final VoidCallback onToggleStar;

  Color _statusColor(String s) {
    switch (s) {
      case 'Fresh':
        return const Color(0xFFBFE9FF);
      case 'Warm':
        return Colors.orange.shade200;
      case 'Hot':
        return Colors.red.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pillColor = _statusColor(item.status);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: name + phone + "Details"
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(item.phone, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.grid_on, size: 14, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text('Details',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Status pill and star
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.status,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ), // Use a Chip/FilterChip if needing interactions. [4][10]
            const SizedBox(height: 8),
            IconButton(
              icon:
                  Icon(item.starred ? Icons.star : Icons.star_border_outlined),
              onPressed: onToggleStar,
            ),
          ],
        ),
      ],
    );
  }
}

class CallItem {
  final String name;
  final String phone;
  final String status;
  final DateTime createdOn;
  final String assignee;
  bool starred;

  CallItem({
    required this.name,
    required this.phone,
    required this.status,
    required this.createdOn,
    required this.assignee,
    this.starred = false,
  });
}
