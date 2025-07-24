// == Mood Analytics Screen ==
// This file implements a dashboard that groups saved mood entries by date,
// computes daily averages, and displays them with emojis and color cues.

// Dart import for JSON parsing
import 'dart:convert';
// Flutter material UI library (similar to QtWidgets or std::gui)
import 'package:flutter/material.dart';
// Shared preferences package for simple key-value storage (like writing to a file)
import 'package:shared_preferences/shared_preferences.dart';
// Model class representing a single mood entry (value + timestamp)
import 'mood_entry.dart';
// Intl package for date formatting (like strftime in C)
import 'package:intl/intl.dart';

/// Maps a mood score (1–10) to an emoji character.
/// In C++ terms, this is like a static std::map<int, std::string>.
String getEmoji(int mood) {
  const emojiMap = {
    1: '😭', 2: '😢', 3: '😞', 4: '😕', 5: '😐',
    6: '🙂', 7: '😊', 8: '😁', 9: '😄', 10: '🤩',
  };
  // Return the emoji or a fallback if the key isn't found
  return emojiMap[mood] ?? '❓';
}

/// Interpolates a color from red to green based on the average mood.
/// avg=1 → red, avg=10 → green. Similar to linear interpolation in C++.
Color avgColor(double avg) {
  final t = (avg - 1) / 9; // Normalize from [1,10] to [0.0,1.0]
  return Color.lerp(Colors.red, Colors.green, t)!; // Linear interpolation
}

// StatefulWidget: object with mutable state (like a class with member variables in C++)
class MoodAnalyticsScreen extends StatefulWidget {
  const MoodAnalyticsScreen({Key? key}) : super(key: key);

  @override
  _MoodAnalyticsScreenState createState() => _MoodAnalyticsScreenState();
}

// State class: holds data and behavior for MoodAnalyticsScreen
class _MoodAnalyticsScreenState extends State<MoodAnalyticsScreen> {
  // Map date-string → list of mood integers, e.g. {"2025-07-24": [5,7,8]}
  Map<String, List<int>> _dailyMoods = {};

  @override
  void initState() {
    super.initState();
    _loadMoodData(); // Load data when the widget is first created
  }

  /// Loads saved JSON mood entries from SharedPreferences,
  /// decodes them, groups by date key, and stores in _dailyMoods.
  Future<void> _loadMoodData() async {
    final prefs = await SharedPreferences.getInstance(); // Open storage
    final logs = prefs.getStringList('mood_logs') ?? []; // Get list or empty

    final grouped = <String, List<int>>{};
    for (var entryStr in logs) {
      // Equivalent to JSON parsing in C++: rapidjson or nlohmann::json
      final entry = MoodEntry.fromJson(jsonDecode(entryStr));
      // Format timestamp to a date string: 'yyyy-MM-dd'
      final dateKey = DateFormat('yyyy-MM-dd').format(entry.timestamp);
      // Collect mood values in a vector-like list
      grouped.putIfAbsent(dateKey, () => []).add(entry.mood);
    }

    // Trigger UI rebuild with new data (setState like notifying observers)
    setState(() => _dailyMoods = grouped);
  }

  @override
  Widget build(BuildContext context) {
    // Get all date keys and sort descending (most recent first)
    final sortedDates = _dailyMoods.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    // Scaffold = top-level page structure (like a main window)
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark theme background
      // AppBar = top toolbar with title and back button
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white, // Text/icon color
        title: const Text('Analytics Dashboard'),
      ),
      // ListView.builder = efficient scrolling list (like std::vector with loop)
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: sortedDates.length,
        itemBuilder: (context, idx) {
          final dateKey = sortedDates[idx];
          final moods = _dailyMoods[dateKey]!; // Non-null list reference
          // Compute average: sum / count (like accumulate + division)
          final avgVal = moods.reduce((a, b) => a + b) / moods.length;
          // Convert dateKey back to DateTime then to friendly string
          final friendlyDate = DateFormat.yMMMMEEEEd().format(DateTime.parse(dateKey));

          // Card = material design card (like a boxed container)
          return Card(
            color: Colors.grey[500],
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date header
                  Text(
                    friendlyDate,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Wrap = auto-flow layout (similar to flex layout)
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: moods.map((m) {
                      // Each chip shows emoji and numeric value
                      return Chip(
                        backgroundColor: Colors.grey[200],
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(getEmoji(m), style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 4),
                            Text(
                              m.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 12),
                  // Average row: label + colored number + emoji
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Average', style: TextStyle(fontSize: 16, color: Colors.black87)),
                      Row(
                        children: [
                          Text(
                            avgVal.toStringAsFixed(1),
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: avgColor(avgVal)),
                          ),
                          const SizedBox(width: 8),
                          Text(getEmoji(avgVal.round()), style: const TextStyle(fontSize: 32)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}