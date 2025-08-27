import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';

class MessageTemplatesScreen extends StatefulWidget {
  static const route = '/message_template';
  const MessageTemplatesScreen({super.key});

  @override
  State<MessageTemplatesScreen> createState() => _MessageTemplatesScreenState();
}

class _MessageTemplatesScreenState extends State<MessageTemplatesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFBFE6FF)),
    );

    return Scaffold(
      // grey outer bg
      body: Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Message Templates',
            // style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
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
          ]
          ,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                TabBar(
                  controller: _tab,
                  isScrollable: false,
                  labelPadding: EdgeInsets.zero,
                  labelColor: const Color(0xFF0E63FF),
                  unselectedLabelColor: Colors.black87,
                  indicatorColor: const Color(0xFF0E63FF),
                  indicatorWeight: 2.0,
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.whatshot), // WhatsApp icon
                          SizedBox(width: 8),
                          Text('WhatsApp'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sms),
                          SizedBox(width: 8),
                          Text('SMS'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(width: 8),
                          Text('Email'),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Color(0xFFDFE6EA),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tab,
          children: [
            _TemplateList(border: border),
            _TemplateList(border: border),
            _TemplateList(border: border),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFD9F1FF), // light blue
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Color(0xFF15306E)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class _TemplateList extends StatelessWidget {
  const _TemplateList({required this.border});
  final OutlineInputBorder border;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      4,
      (i) => '/thankyoumessage Hello!...',
    );

    return CustomScrollView(
      slivers: [
        // ... SliverAppBar via NestedScrollView or keep your AppBar above
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFBFE6FF), width: 2),
              ),
              child: SliverListSection(items: items), // see below
            ),
          ),
        ),
      ],
    );
  }
}

// Helper that renders items as a column so the container wraps content
class SliverListSection extends StatelessWidget {
  const SliverListSection({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    // Use a Column so height = sum of tiles; scroll is provided by the parent sliver
    return Column(
      children: List.generate(items.length, (index) {
        return Column(
          children: [
            if (index > 0)
              const Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFDFE6EA),
              ),
            ListTile(
              title: Text(items[index], maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_rounded),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              titleAlignment: ListTileTitleAlignment.center,
            ),
          ],
        );
      }),
    );
  }
}