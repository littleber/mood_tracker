// Flutter UI framework
import 'package:flutter/material.dart';

// Screen to show after mood is submitted
import 'confirm_screen.dart';

// Importing mood storage functionality under an alias "storage"
import '../mood_logging/mood_storage.dart' as storage;

// Data model for mood entries (if used to define structure)
import '../mood_logging/mood_entry.dart';

// This is a stateful widget: it maintains dynamic state (in this case, the mood level)
class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({Key? key}) : super(key: key);

  // Returns the associated mutable state object
  @override
  _MoodInputScreenState createState() => _MoodInputScreenState();
}

// This is the "state" part of the widget — holds changing values and UI logic
class _MoodInputScreenState extends State<MoodInputScreen> {
  // Current selected mood level (default = 5)
  int moodLevel = 5;

  // Mapping mood levels (1–10) to emojis
  static const emojiMap = {
    1: '😭',
    2: '😢',
    3: '😞',
    4: '😕',
    5: '😐',
    6: '🙂',
    7: '😊',
    8: '😁',
    9: '😄',
    10: '🤩',
  };

  // Called when user taps "Submit Mood"
  void _logMood() async {
    final selectedEmoji = emojiMap[moodLevel]!;  // Get the emoji for current mood level

    // Save mood to storage (e.g., local file or database)
    await storage.MoodStorage.saveMood(moodLevel);

    // Navigate to the confirmation screen, passing the selected emoji
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(moodEmoji: selectedEmoji),
      ),
    );
  }

  // Describes the UI of this screen
  @override
  Widget build(BuildContext context) {
    final selectedEmoji = emojiMap[moodLevel]!;  // Emoji currently selected based on slider
    return Scaffold(
      backgroundColor: Colors.grey[850],  // Dark background

      // Center everything vertically and horizontally
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),  // Add horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Center the column vertically
            children: [
              // Show the large emoji representing the mood
              Text(
                selectedEmoji,
                style: const TextStyle(fontSize: 100),
              ),

              const SizedBox(height: 20),  // Spacer between emoji and slider

              // Slider to select mood level (1 to 10)
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // Customize the value label
                  valueIndicatorTextStyle: const TextStyle(
                    fontSize: 24,            // Change this to make the label bigger
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  value: moodLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: moodLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      moodLevel = value.round();
                    });
                  },
                ),
              ),

              const SizedBox(height: 50),  // Spacer between slider and button

              // Submit button
              ElevatedButton(
                onPressed: _logMood, // Call the logging function
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20), // Bigger padding
                  minimumSize: const Size(200, 60),  // Minimum button size (width x height)
                  textStyle: const TextStyle(
                    fontSize: 20,  // Larger font
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Submit Mood'), // Button label
              ),
            ],
          ),
        ),
      ),
    );
  }
}
