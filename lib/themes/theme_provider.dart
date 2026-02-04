import 'package:flutter/material.dart';
import 'package:qr_code_scanner/themes/dark_theme.dart';
import 'light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

  bool get isDarkTheme => _themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }
}
