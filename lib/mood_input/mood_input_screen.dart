import 'package:flutter/material.dart';
import 'confirm_screen.dart';
import '../mood_logging/mood_storage.dart' as storage;
import '../mood_logging/mood_entry.dart';

class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({Key? key}) : super(key: key);

  @override
  _MoodInputScreenState createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  int moodLevel = 5;

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

  void _logMood() async {
    final selectedEmoji = emojiMap[moodLevel]!;

    await storage.MoodStorage.saveMood(moodLevel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(moodEmoji: selectedEmoji),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedEmoji = emojiMap[moodLevel]!;
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
              Slider(
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logMood,
                child: const Text('Submit Mood'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
