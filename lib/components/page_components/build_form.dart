import 'package:flutter/material.dart';
import 'package:tele_crm/constants.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.amountCtrl,
    required this.dateCtrl,
    required this.txnCtrl,
    required this.onPickDate,     // parent handles date picking [8]
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 16),
    this.background = blueBg
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController amountCtrl;
  final TextEditingController dateCtrl;
  final TextEditingController txnCtrl;
  final VoidCallback onPickDate;
  final EdgeInsetsGeometry padding;
  final Color background;

  InputDecoration _inlineLabelDecoration({
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
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Text(
          '$labelText ',
          style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
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
    ); // Do not mark const; labelText varies. [2][7]
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(18)),
      padding: padding,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
            decoration: _inlineLabelDecoration(
              labelText: 'Name:',
              hint: 'First name Middle name Last name',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: _inlineLabelDecoration(
              labelText: 'Email:',
              hint: 'abc.123@gmail.com',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: _inlineLabelDecoration(
              labelText: 'Phone:',
              hint: 'Enter your mobile number',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            decoration: _inlineLabelDecoration(
              labelText: 'Amount:',
              hint: 'Enter donation amount',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: dateCtrl,
            readOnly: true,
            onTap: onPickDate,
            decoration: _inlineLabelDecoration(
              labelText: 'Date:',
              hint: 'DD/MM/YYYY',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: onPickDate,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: txnCtrl,
            decoration: _inlineLabelDecoration(
              labelText: 'Transaction I’d:',
              hint: 'Enter your i’d',
            ),
          ),
        ],
      ),
    );
  }
}
