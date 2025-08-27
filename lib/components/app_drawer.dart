import 'package:flutter/material.dart';
import 'package:tele_crm/screens/dashboard.dart';
import 'package:tele_crm/screens/donation_form.dart';
import 'package:tele_crm/screens/follow_ups.dart';
import 'package:tele_crm/screens/leads.dart';
import 'package:tele_crm/screens/message_template.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pop(context); // close drawer first
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xFFD9F1FF),
        child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Close button (right aligned)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),

          // Logo
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Logo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Dashboard (highlighted)
                Container(
                  margin: const EdgeInsets.only(bottom: 8, right: 100),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.home_filled, color: Colors.white),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    dense: true,
                    onTap: () => _go(context, DashboardScreen.route),
                  ),
                ),

                // Lead & Filter (expandable)
                ExpansionTile(
                  leading:
                      const Icon(Icons.people_outline, color: Colors.black),
                  title: const Text(
                    'Lead & Filter',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: const EdgeInsets.only(left: 32),
                  children: [
                    ListTile(
                      title: const Text('All Leads'),
                      dense: true,
                      onTap: () => _go(context, LeadsScreen.route),
                    ),
                    ListTile(
                      title: const Text('Assigned Leads'),
                      dense: true,
                      onTap: () => _go(context, LeadsScreen.route),
                    ),
                    ListTile(
                      title: const Text('Follow-up Leads'),
                      dense: true,
                      onTap: () => _go(context, FollowUpsScreen.route),
                    ),
                  ],
                ),

                // Campaign
                ListTile(
                  leading:
                      const Icon(Icons.campaign_outlined, color: Colors.black),
                  title: const Text('Campaign',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () => _go(context, DashboardScreen.route),
                ),

                // Call Tracking
                ListTile(
                  leading:
                      const Icon(Icons.phone_outlined, color: Colors.black),
                  title: const Text('Call Tracking',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () => _go(context, DashboardScreen.route),
                ),

                // Message Templates
                ListTile(
                  leading:
                      const Icon(Icons.message_outlined, color: Colors.black),
                  title: const Text('Message Templates',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () => _go(context, MessageTemplatesScreen.route),
                ),

                // Donation Form
                ListTile(
                  leading: const Icon(Icons.description_outlined,
                      color: Colors.black),
                  title: const Text('Donation Form',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () => _go(context, DonationFormPage.route),
                ),

                // Prasadam Form
                ListTile(
                  leading: const Icon(Icons.restaurant_menu_outlined,
                      color: Colors.black),
                  title: const Text('Prasadam Form',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  onTap: () => _go(context, DashboardScreen.route),
                ),

                const SizedBox(height: 20),

                // Setting (expandable)
                ExpansionTile(
                  leading:
                      const Icon(Icons.settings_outlined, color: Colors.black),
                  title: const Text(
                    'Setting',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: const EdgeInsets.only(left: 32),
                  children: [
                    ListTile(
                      title: const Text('Profile Settings'),
                      dense: true,
                      onTap: () => _go(context, DashboardScreen.route),
                    ),
                    ListTile(
                      title: const Text('App Settings'),
                      dense: true,
                      onTap: () => _go(context, DashboardScreen.route),
                    ),
                  ],
                ),

                // Signout
                ListTile(
                  leading:
                      const Icon(Icons.logout_outlined, color: Colors.black),
                  title: const Text(
                    'Signout',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: add real signout logic
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      DashboardScreen.route,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ],
            ),
          ),
        ])));
  }
}
