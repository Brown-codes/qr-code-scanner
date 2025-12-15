import 'package:flutter/material.dart';
import 'package:qr_code_scanner/components/create_qr_list_tile.dart';
import 'package:qr_code_scanner/pages/qr_input_page.dart';
import 'package:qr_code_scanner/pages/qr_result_page.dart';

class CreateQrPage extends StatelessWidget {
  const CreateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Qr Code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrInputPage(type: "Website")
                ),
              ),
              icon: Icons.web,
              title: "Website",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrInputPage(type: "Text")
                ),
              ),
              icon: Icons.text_snippet_sharp,
              title: "Text",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrInputPage(type: "Email")
                ),
              ),
              icon: Icons.email,
              title: "Email",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrInputPage(type: "Email")
                ),
              ),
              icon: Icons.chat,
              title: "SMS",
            ),
            CreateQrListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrInputPage(type: "Wifi")
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
