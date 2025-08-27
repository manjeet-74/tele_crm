import 'package:flutter/material.dart';
import 'package:tele_crm/components/app_drawer.dart';
import 'package:tele_crm/components/notification_bell.dart';

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
  InputDecoration inlineLabelDecoration({
    required String labelText,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      // Inline bold label as prefix (no 48px padding)
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Text(
          '$labelText ',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black87, width: 1),
      ),
    );
  }

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
  void dispose() {
    _nameCTRL.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _amountCtrl.dispose();
    _dateCtrl.dispose();
    _txnCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name: three inline fields within one line of hint text
                      TextFormField(
                        controller: _nameCTRL,
                        decoration: inlineLabelDecoration(
                          labelText: 'Name:',
                          hint: 'First name   Middle name   Last name',
                        ),
                        // Optional: capture in separate fields if needed using an overlay or custom row
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inlineLabelDecoration(
                          labelText: 'Email:',
                          hint: 'abc.123@gmail.com',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Phone
                      TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: inlineLabelDecoration(
                          labelText: 'Phone:',
                          hint: 'Enter your mobile number',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Amount
                      TextFormField(
                        controller: _amountCtrl,
                        keyboardType: TextInputType.number,
                        decoration: inlineLabelDecoration(
                          labelText: 'Amount:',
                          hint: 'Enter your mobile number',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date
                      TextFormField(
                        controller: _dateCtrl,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: inlineLabelDecoration(
                          labelText: 'Date:',
                          hint: 'DD/MM/YYYY',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today_outlined),
                            onPressed: _pickDate,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Transaction Id
                      TextFormField(
                        controller: _txnCtrl,
                        decoration: inlineLabelDecoration(
                          labelText: 'Transaction I’d:',
                          hint: 'Enter your i’d',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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


// InputDecoration _inlineLabelDecoration({
//   required String labelText,
//   required String hint,
// }) {
//   return InputDecoration(
//     hintText: hint,
//     isDense: true,
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//     // Inline bold label as prefix
//     prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0), // remove 48px min [10][13]
//     prefixIcon: Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8),
//       child: Text(
//         '$labelText ',
//         style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
//       ),
//     ),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(color: Colors.grey.shade300),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(color: Colors.grey.shade300),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.black87, width: 1),
//     ),
//   );
// }
