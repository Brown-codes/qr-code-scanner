import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _keyVibrate = 'setting_vibrate';
  static const String _keyAutoOpen = 'setting_auto_open';

  static Future<bool> getVibrate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyVibrate) ?? true;
  }

  static Future<void> setVibrate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyVibrate, value);
  }

  static Future<bool> getAutoOpen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAutoOpen) ?? false;
  }

  static Future<void> setAutoOpen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoOpen, value);
  }
}
