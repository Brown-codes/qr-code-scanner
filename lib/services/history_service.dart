import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {

  static const String _key = "scan_history";

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)??  [];
  }

  static Future<void> addToHistory(String code) async{
    final prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList(_key) ?? [];

    if (history.contains(code)){
      history.remove(code);
    }
    
    history.insert(0, code);

    await prefs.setStringList(_key, history);
  }

  static Future<void> clearHistory() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<void> deleteItem(String code) async {
    final prefs = await SharedPreferences.getInstance();

    // Load current list
    List<String> history = prefs.getStringList(_key) ?? [];

    // Remove the item
    history.remove(code);

    // Save back to phone
    await prefs.setStringList(_key, history);
  }
}