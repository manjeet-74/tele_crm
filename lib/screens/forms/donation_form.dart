import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';
import 'package:tele_crm/components/page_components/build_form.dart';

class DonationFormPage extends StatefulWidget {
  const DonationFormPage({super.key});
  static const route = '/donation_form';

  @override
  State<DonationFormPage> createState() => _DonationFormPageState();
}

class _DonationFormPageState extends State<DonationFormPage> {
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
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Donation Form',
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
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
              // Footer chips
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ActionChip(icon: Icons.crop_free, label: 'Screenshot'),
                    _ActionChip(icon: Icons.attachment_rounded, label: 'Attachment'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.black87),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}



