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
    final selectedEmoji = emojiMap[moodLevel]!;
  
    return Scaffold(
      backgroundColor: Colors.grey[850],
  
      // 1) Add an AppBar with a back button
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);   // Simply go back
          },
        ),
        title: const Text('How are you feeling?', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
  
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedEmoji,
                style: const TextStyle(fontSize: 100),
              ),
  
              const SizedBox(height: 20),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorTextStyle: const TextStyle(
                    fontSize: 24,
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
  
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _logMood,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  minimumSize: const Size(200, 60),
                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('Submit Mood'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
