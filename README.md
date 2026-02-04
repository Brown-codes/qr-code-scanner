# LensQR - QR Code Scanner & Generator

LensQR is a modern, fast, and feature-rich QR code application built with Flutter. It allows users to scan various types of QR codes, generate their own, and manage their scan history with a sleek user interface.

## 🚀 Features

- **Fast QR Scanning**: Quickly scan QR codes using the device camera.
- **QR Generation**: Create QR codes for:
  - Websites (URLs)
  - Plain Text
  - Emails
  - SMS
  - WiFi Networks
- **History Management**: Keep track of your scanned codes with the ability to delete or copy them.
- **Theming**: Supports both Light and Dark modes.
- **Customizable Settings**:
  - Toggle vibration on scan.
  - Auto-open URLs for a seamless experience.
- **Export & Share**: Save generated QR codes to your gallery or share them directly with others.

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - Framework
- [Provider](https://pub.dev/packages/provider) - State Management
- [Mobile Scanner](https://pub.dev/packages/mobile_scanner) - Scanning Engine
- [QR Flutter](https://pub.dev/packages/qr_flutter) - QR Code Generation
- [Shared Preferences](https://pub.dev/packages/shared_preferences) - Local Storage
- [Gal](https://pub.dev/packages/gal) - Save to Gallery
- [Share Plus](https://pub.dev/packages/share_plus) - Sharing Functionality

## 📦 Getting Started

### Prerequisites

- Flutter SDK (Latest Version)
- Android Studio / VS Code
- Android/iOS Device or Emulator

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/lens-qr.git
   ```

2. Navigate to the project directory:
   ```bash
   cd lens-qr
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🛡️ Permissions

This app requires the following permissions:
- **Camera**: To scan QR codes.
- **Storage/Photo Library**: To save generated QR codes to the device gallery.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
