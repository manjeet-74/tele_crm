import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';

class MessageDetailsPage extends StatefulWidget {
  static const route = '/message_details';
  const MessageDetailsPage({super.key});

  @override
  State<MessageDetailsPage> createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController(text: '''
Lorem ipsum dolor sit amet consectetur. Maecenas vitae volutpat tellus cursus vitae nibh habitant. Egestas elementum volutpat adipiscing laoreet sit sed. 
Suspendisse nibh dui risus nisi aliquet vestibulum posuere pellentesque...''');

  final List<_VarField> _vars = [
    const _VarField(keyName: 'my_name', label: 'my name'),
    const _VarField(keyName: 'role', label: 'Role'),
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final greyBg = Colors.grey.shade200;
    final onSurfaceStrong = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      drawer: const AppDrawer(), // optional
      appBar: AppBar(
        title: const Text('Message Templates'),
        centerTitle: true,
        leading: Builder(
          builder: (c) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(c).openDrawer(),
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
        ],
      ), // body:
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            children: [
              // Title input (same as before) ...
              TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  hintText: 'Title',
                  filled: true,
                  fillColor: greyBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                ),
              ),
              const SizedBox(height: 12),

              // Variables row (same) ...
              Row(
                children: [
                  Text('Variables:', style: theme.textTheme.bodyMedium),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChipTheme(
                      data: ChipTheme.of(context).copyWith(
                        backgroundColor: greyBg,
                        selectedColor: greyBg,
                        disabledColor: greyBg,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelStyle: theme.textTheme.bodyMedium,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ..._vars.map((f) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InputChip(
                                    label: Text(f.label),
                                    backgroundColor: greyBg,
                                    labelStyle: TextStyle(
                                      color: onSurfaceStrong,          // same family as Title
                                      fontWeight: FontWeight.w600,     // similar emphasis to Title
                                      letterSpacing: 0.1,
                                    ),
                                    side: BorderSide.none,
                                  ),
                                )),
                            ActionChip(
                              avatar: const Icon(Icons.add, size: 18),
                              label: const Text('Add Fields'),
                              onPressed: _showAddFieldDialog,
                              backgroundColor: greyBg,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Editor fills the rest
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.lightBlue, width: 1.5),
                    color: theme.colorScheme.surface,
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    children: [
                      // Make the text area scrollable and fill available height
                      Expanded(
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: _bodyCtrl,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  'Write your message here. Use {{my_name}} and {{role}}.',
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _roundIconButton(context,
                              icon: Icons.save_outlined, onTap: _saveTemplate),
                          const SizedBox(width: 16),
                          _roundIconButton(context,
                              icon: Icons.send_outlined, onTap: _sendTemplate),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundIconButton(BuildContext context,
      {required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.lightBlue.shade100,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
      ),
    );
  }

  void _showAddFieldDialog() {
    final keyCtrl = TextEditingController();
    final labelCtrl = TextEditingController();
    bool requiredFlag = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: const Text('Add Variable'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: labelCtrl,
                  decoration: const InputDecoration(labelText: 'Label')),
              TextField(
                  controller: keyCtrl,
                  decoration: const InputDecoration(labelText: 'Key')),
              CheckboxListTile(
                value: requiredFlag,
                onChanged: (v) => setS(() => requiredFlag = v ?? false),
                title: const Text('Required'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                if (keyCtrl.text.trim().isEmpty ||
                    labelCtrl.text.trim().isEmpty) return;
                setState(() {
                  _vars.add(_VarField(
                    keyName: keyCtrl.text.trim(),
                    label: labelCtrl.text.trim(),
                    required: requiredFlag,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTemplate() {
    // TODO: integrate with repository.save({title, body, vars})
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Template saved')));
    Navigator.pop(context);
  }

  void _sendTemplate() {
    // TODO: integrate with send/preview action
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Template sent/preview')));
  }
}

class _VarField {
  final String keyName;
  final String label;
  final bool required;
  const _VarField(
      {required this.keyName, required this.label, this.required = false});
}
