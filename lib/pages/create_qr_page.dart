import 'package:flutter/material.dart';
import 'package:qr_code_scanner/components/create_qr_list_tile.dart';
import 'package:qr_code_scanner/pages/qr_input_page.dart';

class CreateQrPage extends StatelessWidget {
  const CreateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create QR Code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrInputPage(type: "Website"),
                ),
              ),
              icon: Icons.web,
              title: "Website",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrInputPage(type: "Text"),
                ),
              ),
              icon: Icons.text_snippet_sharp,
              title: "Text",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrInputPage(type: "Email"),
                ),
              ),
              icon: Icons.email,
              title: "Email",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrInputPage(type: "SMS"),
                ),
              ),
              icon: Icons.chat,
              title: "SMS",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrInputPage(type: "Wifi"),
                ),
              ),
              icon: Icons.wifi,
              title: "Wifi",
            ),
          ],
        ),
      ),
    );
  }
}
