// Importing the Flutter Material library, which provides material design components
import 'package:flutter/material.dart';

// Importing your custom idle screen widget from another Dart file
import 'start/idle_screen.dart';  // import your idle screen
import 'mood_logging/mood_history_screen.dart';
import 'mood_logging/mood_analytics_screen.dart';
// Entry point of the Flutter application
void main() {
  // This function initializes and runs the app.
  // `const MyApp()` creates a widget instance of your root app.
  runApp(const MyApp());
}

// This defines a custom widget class `MyApp`
// In Flutter, everything is a widget (like components in UI).
// `StatelessWidget` means the UI does not depend on any internal state that might change over time.
class MyApp extends StatelessWidget {
  // Constructor with an optional `key` argument for widget identity
  const MyApp({super.key});

  // This method describes how to display the widget in terms of other widgets.
  @override
  Widget build(BuildContext context) {
    // `MaterialApp` is the top-level widget that sets up app-level configuration
    return MaterialApp(
      title: 'Mood Tracker',                // Title of the app (used in OS task switcher etc.)
      debugShowCheckedModeBanner: false,   // Removes the "debug" banner in the corner
      home: const IdleScreen(),            // This is the first screen that shows when the app starts
      routes: {
        '/analytics': (context) => const MoodAnalyticsScreen(),
      },
    );
  }
}
