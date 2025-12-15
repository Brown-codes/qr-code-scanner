import 'package:flutter/material.dart';
import 'package:qr_code_scanner/pages/create_qr_page.dart';
import 'package:qr_code_scanner/pages/home_page.dart';
import 'package:qr_code_scanner/pages/qr_result_page.dart';
import 'package:qr_code_scanner/pages/recent_page.dart';
import 'package:qr_code_scanner/pages/scan_qr_page.dart';
import 'package:qr_code_scanner/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LensQR',
      // home: HomePage(),
      routes: {
        "/" : (context) => HomePage(),
        "/create_qr" : (context) => CreateQrPage(),
        "/recent" : (context) => RecentPage(),
        "/scan_qr" : (context) => ScanQrPage(),
        "/settings" : (context)  => SettingsPage()
      },
    );
  }
}

