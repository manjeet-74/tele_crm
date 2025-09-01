import 'package:flutter/material.dart';
import 'package:tele_crm/screens/android_permission.dart';
import 'package:tele_crm/screens/call_report.dart';
import 'package:tele_crm/screens/call_report.dart';
import 'package:tele_crm/screens/campaign.dart';
import 'package:tele_crm/screens/campaign_details.dart';
import 'package:tele_crm/screens/dashboard.dart';
import 'package:tele_crm/screens/forms/donation_form.dart';
import 'package:tele_crm/screens/follow_ups.dart';
import 'package:tele_crm/screens/forms/prasadam_form.dart';
import 'package:tele_crm/screens/forms/prasadam_form.dart';
import 'package:tele_crm/screens/lead_details.dart';
import 'package:tele_crm/screens/leads.dart';
import 'package:tele_crm/screens/login.dart';
import 'package:tele_crm/screens/message_template.dart';
import 'package:tele_crm/screens/message_details.dart';
import 'package:tele_crm/screens/profile_page.dart';
import 'package:tele_crm/screens/sim_card_manager.dart';
import 'package:tele_crm/screens/sim_card_manager.dart';

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
        CampaignScreen.route: (_) => const CampaignScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
        ProfilePageScreen.route: (_) => const ProfilePageScreen(),
        DonationFormPage.route: (_) => const DonationFormPage(),
        PrasadamFormPage.route: (_) => const PrasadamFormPage(),
        MessageTemplatesScreen.route: (_) => const MessageTemplatesScreen(),
        MessageDetailsPage.route: (_) => const MessageDetailsPage(),
        SimCardManagerPage.route: (_) => const SimCardManagerPage(),
        AndroidPermissionsPage.route: (_) => const AndroidPermissionsPage(),
        CallReportPage.route: (_) => const CallReportPage(),
        LeadDetailsScreen.route: (_) => const LeadDetailsScreen(
              leadId: 'LD-0001',
              name: 'Jane Cooper',
              phone: '+91-564646454',
              status: 'Fresh',
            ),
        CampaignDetailsScreen.route: (_) => const CampaignDetailsScreen(
          leadId: 'LD-0001',
          name: 'Jane Cooper',
          phone: '+91-564646454',
          status: 'Fresh',
        ),
      },
    );
  }
}
