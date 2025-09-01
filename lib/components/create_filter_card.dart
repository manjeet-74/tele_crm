import 'package:flutter/material.dart';
import 'package:tele_crm/constants.dart';

class CreateFilterCard extends StatelessWidget {
  const CreateFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: blueBg, // light blue button bg
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      onPressed: () {},
      child: const Text('+ Create Filter'),
    );
  }
}

