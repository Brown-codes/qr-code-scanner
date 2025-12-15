import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController _mobileScannerController =
      MobileScannerController();
  bool _isScanning = false;

  @override
  void dispose() {
    _mobileScannerController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleScan(BarcodeCapture capture) async {
    if (_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isEmpty || barcodes.first.rawValue == null) return;

    final String code = barcodes.first.rawValue!;

    setState(() {
      _isScanning = true;
    });

    final Uri? uri = Uri.tryParse(code);
    final bool isUrl =
        uri != null && (uri.scheme == "http" || uri.scheme == "https");

    if (isUrl) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar("Found Text$code");
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Found code: $code"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () => _mobileScannerController.toggleTorch(),
            icon: Icon(Icons.flash_on),
          ),
          IconButton(
            onPressed: () => _mobileScannerController.switchCamera(),
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: _handleScan,
          ),
          Align(
            child: Text(
              "Point camera at a code",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
