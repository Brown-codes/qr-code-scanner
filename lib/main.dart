import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/pages/create_qr_page.dart';
import 'package:qr_code_scanner/pages/home_page.dart';
import 'package:qr_code_scanner/pages/recent_page.dart';
import 'package:qr_code_scanner/pages/scan_qr_page.dart';
import 'package:qr_code_scanner/pages/settings_page.dart';
import 'package:qr_code_scanner/themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LensQR',
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/": (context) => HomePage(),
        "/create_qr": (context) => CreateQrPage(),
        "/recent": (context) => RecentPage(key: UniqueKey()),
        "/scan_qr": (context) => ScanQrPage(),
        "/settings": (context) => SettingsPage(),
      },
    );
  }
}
