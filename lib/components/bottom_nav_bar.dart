import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 16, left: 16),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/"),
            child: Column(
              children: [
                Icon(Icons.create, color: Colors.white),
                SizedBox(height: 5),
                Text("Create QR", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
                Navigator.pushNamed(context, "/scan_qr");
              });
            },
            child: Column(
              children: [
                Icon(Icons.document_scanner, color: isSelected? Colors.grey.shade600 :Colors.white),
                SizedBox(height: 5),
                Text("Scan QR", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/recent"),
            child: Column(
              children: [
                Icon(Icons.history, color: Colors.white),
                SizedBox(height: 5),
                Text("Recent", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/settings"),
            child: Column(
              children: [
                Icon(Icons.settings, color: Colors.white),
                SizedBox(height: 5),
                Text("Settings", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
