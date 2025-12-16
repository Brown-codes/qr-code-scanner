import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _vibrate = true;
  bool _autoOpen = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final vibrate = await SettingsService.getVibrate();
    final autoOpen = await SettingsService.getAutoOpen();
    setState(() {
      _vibrate = vibrate;
      _autoOpen = autoOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // Section 1: Behavior
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Scanner Behavior",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),

          SwitchListTile(
            title: const Text("Vibrate on Scan"),
            subtitle: const Text("Vibrate when a QR code is detected"),
            value: _vibrate,
            onChanged: (bool value) async {
              setState(() => _vibrate = value);
              await SettingsService.setVibrate(value);
            },
            secondary: const Icon(Icons.vibration),
          ),

          SwitchListTile(
            title: const Text("Auto-Open Websites"),
            subtitle: const Text("Open URLs automatically without asking"),
            value: _autoOpen,
            onChanged: (bool value) async {
              setState(() => _autoOpen = value);
              await SettingsService.setAutoOpen(value);
            },
            secondary: const Icon(Icons.open_in_browser),
          ),

          Padding(padding: const EdgeInsets.all(16.0), child: const Divider()),

          // Section 2: dark, light
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Theme",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
