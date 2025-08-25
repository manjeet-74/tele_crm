import 'package:flutter/material.dart';
import 'package:tele_crm/screens/lead_details.dart';

class LeadsScreen extends StatefulWidget {
  static const route = '/leads';
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  final _query = TextEditingController();
  final _leads = List.generate(
    10,
        (i) => ({
      'id': 'LD-${(i + 1).toString().padLeft(4, '0')}',
      'name': 'Name',
      'phone': '+91-564646454',
      'status': 'Fresh',
    }),
  );

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const borderBlue = Color(0xFFBFE9FF); // light stroke like screenshot
    const chipBlue = const Color(0xFFD9F1FF); // pill bg

    return Scaffold(
      drawer: const _DummyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Lead & Filter'),
        centerTitle: true,
        actions: [
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10)
            ),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Leads',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    backgroundColor: chipBlue, // light blue button bg
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text('+ Create Filter'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // List
          Expanded(
            child: // Replace only the ListView.separated part in your existing code:

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: _leads.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final m = _leads[i];
                  // Safe null checks using ?? operator
                  final name = m['name'] ?? 'Unknown';
                  final phone = m['phone'] ?? '+91-564646454';
                  final status = m['status'] ?? 'Fresh';

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.pushNamed(
                        context,
                        LeadDetailsScreen.route,
                        arguments: m['id'],
                      ),
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: borderBlue, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top row: Name + menu
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Phone
                              Text(
                                phone,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Status row: label, pill, star
                              Row(
                                children: [
                                  Text(
                                    'Status:',
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Status pill
                                  Chip(
                                    label: Text(
                                      status,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    backgroundColor: chipBlue,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    visualDensity: VisualDensity.compact,
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(Icons.star_border_rounded),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New lead'),
      ),
    );
  }
}

class _DummyDrawer extends StatelessWidget {
  const _DummyDrawer();

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Menu'),
        ),
      ),
    );
  }
}
