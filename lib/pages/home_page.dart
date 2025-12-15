import 'package:flutter/material.dart';
import 'package:qr_code_scanner/components/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "LensQR",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.camera_alt),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Scan QR Code",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
              ),
              Text(
                "Position the QR code within the frame",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Center(child: Icon(Icons.document_scanner_outlined, size: 200)),
            ],
          ),
        ),
      ),
    );
  }
}
