import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import '../themes/theme_provider.dart';

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
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
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
          const Divider(indent: 16, endIndent: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Appearance",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: Provider.of<ThemeProvider>(context).isDarkTheme,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
