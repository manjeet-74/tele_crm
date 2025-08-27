import 'package:flutter/material.dart';
import 'package:tele_crm/screens/dashboard.dart';
import 'package:tele_crm/screens/donation_form.dart';
import 'package:tele_crm/screens/follow_ups.dart';
import 'package:tele_crm/screens/lead_details.dart';
import 'package:tele_crm/screens/leads.dart';
import 'package:tele_crm/screens/login.dart';
import 'package:tele_crm/screens/message_template.dart';
import 'package:tele_crm/screens/profile_page.dart';

void main() => runApp(const TeleCrmApp());

class TeleCrmApp extends StatelessWidget {
  const TeleCrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    final light = ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1967D2),
        secondary: Color(0xFF00BFA6),
        surface: Colors.white,
        onSurface: Color(0xFF1F242B),
      ),
      useMaterial3: true,
    ).copyWith(
      textTheme: Typography.blackCupertino,
    );

    final dark = ThemeData.from(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF8AB4F8),
        secondary: Color(0xFF64FFDA),
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'TeleCRM',
      themeMode: ThemeMode.system,
      theme: light,
      darkTheme: dark,
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (_) => const LoginScreen(),
        FollowUpsScreen.route: (_) => const FollowUpsScreen(),
        LeadsScreen.route: (_) => const LeadsScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
        ProfilePageScreen.route: (_) => const ProfilePageScreen(),
        DonationFormPage.route: (_) => const DonationFormPage(),
        MessageTemplatesScreen.route: (_) => const MessageTemplatesScreen(),
        LeadDetailsScreen.route: (_) => const LeadDetailsScreen(
              leadId: 'LD-0001',
              name: 'Jane Cooper',
              phone: '+91-564646454',
              status: 'Fresh',
            ),
      },
    );
  }
}
