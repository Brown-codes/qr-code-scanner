import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/history_service.dart';
import '../services/settings_service.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController _mobileScannerController = MobileScannerController();
  bool _isScanning = false;

  @override
  void dispose() {
    _mobileScannerController.dispose();
    super.dispose();
  }

  void _handleScan(BarcodeCapture capture) async {

    if (_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty || barcodes.first.rawValue == null) return;

    setState(() {
      _isScanning = true;
    });

    final String code = barcodes.first.rawValue!;


    await HistoryService.addToHistory(code);


    final shouldVibrate = await SettingsService.getVibrate();
    if (shouldVibrate) {
      HapticFeedback.vibrate();
    }


    final shouldAutoOpen = await SettingsService.getAutoOpen();

    final Uri? uri = Uri.tryParse(code);
    final bool isUrl = uri != null && (uri.scheme == "http" || uri.scheme == "https");

    if (isUrl && shouldAutoOpen) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);

        // Reset scanning after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _isScanning = false);
        });
        return;
      }
    }

    // 6. Default Behavior (Show Dialog)
    // If we didn't auto-open, show the popup
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Code Found"),
          content: Text(code),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                setState(() => _isScanning = false); // Resume scanning
              },
              child: const Text("OK"),
            ),
            if (isUrl)
              TextButton(
                onPressed: () {
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                  Navigator.pop(context);
                  setState(() => _isScanning = false);
                },
                child: const Text("Open"),
              ),
          ],
        ),
      ).then((_) {
        // Just in case they click outside the box to close it
        setState(() => _isScanning = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () => _mobileScannerController.toggleTorch(),
            icon: const Icon(Icons.flash_on),
          ),
          IconButton(
            onPressed: () => _mobileScannerController.switchCamera(),
            icon: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: _handleScan,
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Point camera at a code",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    backgroundColor: Colors.black54
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}