import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Dashboard_screen.dart';
import 'profile.dart';
import 'calendar_page.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  // These are the 4 parts of your assignment:
  final List<Widget> _pages = [
    const DashboardScreen(), // 1. Tasks
    const MovingCalendar(),
    const ProfileScreen(), // 3. Profile
    const SettingsScreen(), // 4. Settings Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red,
        items: const <Widget>[
          Icon(Icons.dashboard, size: 30, color: Colors.white),
          Icon(Icons.calendar_month, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
