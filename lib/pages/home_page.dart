import 'package:flutter/material.dart';
import 'package:qr_code_scanner/components/bottom_nav_bar.dart';
import 'package:qr_code_scanner/pages/recent_page.dart';
import 'package:qr_code_scanner/pages/settings_page.dart';
import 'create_qr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _handleTabChange(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, "/scan_qr").then((_) {
        setState(() {});
      });
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const CreateQrPage(),
    const SizedBox(), // Placeholder for scan page which is pushed via Navigator
    RecentPage(key: UniqueKey()),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _handleTabChange,
      ),
      body: SafeArea(child: pages[_selectedIndex]),
    );
  }
}
