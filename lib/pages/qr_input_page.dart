import 'package:flutter/material.dart';
import 'package:qr_code_scanner/pages/qr_result_page.dart';

class QrInputPage extends StatefulWidget {
  final String type;
  const QrInputPage({super.key, required this.type});

  @override
  State<QrInputPage> createState() => _QrInputPageState();
}

class _QrInputPageState extends State<QrInputPage> {
  final TextEditingController _textEditingController = TextEditingController();

  void generateQRCode() {
    final String data = _textEditingController.text;

    if (data.isEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(content: Text("Please enter some data!")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrResultPage(data: data, type: widget.type),
      ),
    );
  }
  @override
  void dispose() {
   _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "What should this QR code say?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "Enter ${widget.type} here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => generateQRCode(),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade900,
                    ),
                    child: Center(
                      child: Text(
                        "Generate",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
