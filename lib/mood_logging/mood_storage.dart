import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'mood_entry.dart';

class MoodStorage {
  static const String _key = 'mood_logs';

  static Future<void> saveMood(int mood) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = prefs.getStringList(_key) ?? [];

    final newEntry = MoodEntry(mood: mood, timestamp: DateTime.now());
    logs.add(jsonEncode(newEntry.toJson()));

    await prefs.setStringList(_key, logs);
  }

  static Future<List<MoodEntry>> loadMoods() async {
    final prefs = await SharedPreferences.getInstance();
    final logs = prefs.getStringList(_key) ?? [];

    return logs.map((entry) {
      final Map<String, dynamic> data = jsonDecode(entry);
      return MoodEntry.fromJson(data);
    }).toList();
  }

  static Future<void> clearMoods() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
