import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _keyVibrate = 'setting_vibrate';
  static const String _keyAutoOpen = 'setting_auto_open';

  // 1. Get Vibrate Setting (Default: true)
  static Future<bool> getVibrate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyVibrate) ?? true;
  }

  // 2. Set Vibrate Setting
  static Future<void> setVibrate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyVibrate, value);
  }

  // 3. Get Auto-Open Setting (Default: false)
  static Future<bool> getAutoOpen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAutoOpen) ?? false;
  }

  // 4. Set Auto-Open Setting
  static Future<void> setAutoOpen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoOpen, value);
  }
}