// Dart package for converting between JSON strings and data structures
import 'dart:convert';

// Flutter plugin for simple key-value persistent storage
import 'package:shared_preferences/shared_preferences.dart';

// Import your mood entry data model
import 'mood_entry.dart';

// Static utility class for handling mood data storage
class MoodStorage {
  // Key used to store/retrieve mood entries in shared preferences
  static const String _key = 'mood_logs';

  // Save a mood entry (with current timestamp) to local storage
  static Future<void> saveMood(int mood) async {
    // Get access to SharedPreferences (like a lightweight local database)
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing mood entries (as a list of JSON strings), or initialize empty
    final logs = prefs.getStringList(_key) ?? [];

    // Create a new MoodEntry with the current timestamp
    final newEntry = MoodEntry(mood: mood, timestamp: DateTime.now());

    // Convert the entry to a JSON string and add to the logs
    logs.add(jsonEncode(newEntry.toJson()));

    // Save the updated list of logs back to SharedPreferences
    await prefs.setStringList(_key, logs);
  }

  // Load all saved mood entries from local storage
  static Future<List<MoodEntry>> loadMoods() async {
    // Access the shared preferences instance
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the list of saved JSON mood entries
    final logs = prefs.getStringList(_key) ?? [];

    // Convert each JSON string back into a MoodEntry object
    return logs.map((entry) {
      final Map<String, dynamic> data = jsonDecode(entry);  // Parse JSON
      return MoodEntry.fromJson(data);                      // Convert to MoodEntry
    }).toList();  // Convert iterable to a List<MoodEntry>
  }

  // Clear all saved mood entries from storage
  static Future<void> clearMoods() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);  // Remove the stored mood list
  }
}
