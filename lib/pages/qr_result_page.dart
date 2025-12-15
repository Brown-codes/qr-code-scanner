import 'dart:io';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class QrResultPage extends StatefulWidget {
  final String? data;
  final String? type;
  const QrResultPage({super.key, this.data, this.type});

  @override
  State<QrResultPage> createState() => _QrResultPageState();
}

class _QrResultPageState extends State<QrResultPage> {
  Future<void> _saveQrCode(BuildContext context) async {
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
      }

      final qrValidationResult = QrValidator.validate(
        data: widget.data!,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (qrValidationResult.status == QrValidationStatus.valid) {
        final qrCode = qrValidationResult.qrCode!;

        const double size = 875;
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);

        //the white background
        final paint = Paint()..color = Colors.white;
        canvas.drawRect(const Rect.fromLTWH(0, 0, size, size), paint);

        final painter = QrPainter.withQr(
          qr: qrCode,
          dataModuleStyle: QrDataModuleStyle(color: Colors.black),
          gapless: true,
        );
        painter.paint(canvas, Size(size, size));

        final picture = recorder.endRecording();
        final img = await picture.toImage(size.toInt(), size.toInt());

        final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          final Uint8List pngBytes = byteData.buffer.asUint8List();

          // 7. Save
          await Gal.putImageBytes(pngBytes);

          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(content: Text("Saved to Gallery!")),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text("Error Saving $e")),
        );
      }
    }
  }

  Future<void> _shareQrCode(BuildContext context) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: widget.data!,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (qrValidationResult.status == QrValidationStatus.valid) {
        final qrCode = qrValidationResult.qrCode!;

        const double size = 875;
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);

        //the white background
        final paint = Paint()..color = Colors.white;
        canvas.drawRect(const Rect.fromLTWH(0, 0, size, size), paint);

        final painter = QrPainter.withQr(
          qr: qrCode,
          dataModuleStyle: QrDataModuleStyle(color: Colors.black),
          gapless: true,
        );
        painter.paint(canvas, Size(size, size));

        final picture = recorder.endRecording();
        final img = await picture.toImage(size.toInt(), size.toInt());
        final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          final Uint8List pngBytes = byteData.buffer.asUint8List();

          // 7. Save
          final directory = await getTemporaryDirectory();
          final path = '${directory.path}/qr_share.png';
          final file = File(path);
          await file.writeAsBytes(pngBytes);

          await SharePlus.instance.share(
            ShareParams(
              files: [XFile(path)],
              text: 'Here is my QR code for $widget.type!',
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text("Error Sharing $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("result ")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(40),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QrImageView(
                      data: widget.data!,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Here is your code",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "This your unique QR code",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => _shareQrCode(context),
                          child: _actionButton(Icons.share, "Share"),
                        ),
                        GestureDetector(
                          onTap: () => _saveQrCode(context),
                          child: _actionButton(Icons.save_alt_outlined, "Save"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _actionButton(IconData icon, String title) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon),
      ),

      SizedBox(height: 10),
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}
