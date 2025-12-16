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

  int _selectedIndex = 1; // Start at index 1 (Scan/Home)

  void _handleTabChange(int index) {
    // Special Case: If user clicks "Scan" (Index 1), we want to push the camera
    // This keeps the camera separate from the tabs
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
    const CreateQrPage(),            // Index 0
    const _HomeDashboard(),          // Index 1 (Your original Home UI)
    RecentPage(key: UniqueKey()),    // Index 2 (UniqueKey forces reload!)
    const SettingsPage(),            // Index 3
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


class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("LensQR", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Icon(Icons.camera_alt),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Scan QR Code", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
          const Text("Position the QR code within the frame", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 40),
          const Center(child: Icon(Icons.document_scanner_outlined, size: 200)),
        ],
      ),
    );
  }
}
