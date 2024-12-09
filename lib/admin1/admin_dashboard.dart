import 'package:flutter/material.dart';

import 'dashboard_overview.dart';
import 'manage_attractions.dart';
import 'manage_notifications.dart';
import 'manage_reviews.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardOverview(),
    ManageAttractions(),
    const ManageReviews(),
    const ManageNotifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff579f8c),
      appBar: AppBar(
        title: const Text('... DashBoard ...'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout logic here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color:  Color(0xff579f8c),
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () => setState(() => _currentIndex = 0),
            ),
            ListTile(
              title: const Text('Manage Attractions'),
              onTap: () => setState(() => _currentIndex = 1),
            ),
            ListTile(
              title: const Text('Manage Reviews'),
              onTap: () => setState(() => _currentIndex = 2),
            ),
            ListTile(
              title: const Text('Manage Notifications'),
              onTap: () => setState(() => _currentIndex = 3),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}