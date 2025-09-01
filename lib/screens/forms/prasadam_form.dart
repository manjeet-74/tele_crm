import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';
import 'package:tele_crm/components/page_components/build_form.dart';

class PrasadamFormPage extends StatefulWidget {
  const PrasadamFormPage({super.key});
  static const route = '/prasadam_form';

  @override
  State<PrasadamFormPage> createState() => _PrasadamFormPageState();
}

class _PrasadamFormPageState extends State<PrasadamFormPage> {
  final _nameCTRL = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _txnCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Base decoration used for inline fields


  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Select Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC9EEFE)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _dateCtrl.text =
      '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Prasadam Form',
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
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Light blue panel
              BuildForm(
                nameCtrl: _nameCTRL,
                emailCtrl: _emailCtrl,
                phoneCtrl: _phoneCtrl,
                amountCtrl: _amountCtrl,
                dateCtrl: _dateCtrl,
                txnCtrl: _txnCtrl,
                onPickDate: _pickDate,
              ), // reusable card [3]
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

}



