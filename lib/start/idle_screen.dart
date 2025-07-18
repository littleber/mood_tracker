import 'package:flutter/material.dart';
import '../mood_input/mood_input_screen.dart';

class IdleScreen extends StatelessWidget {
  const IdleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          // Navigate to MoodInputScreen and wait for result
          final mood = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MoodInputScreen()),
          );

          // Optionally do something with the returned mood (if any)
          if (mood != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Mood submitted: $mood')),
            );
          }
        },
        child: Center(
          child: Text(
            'Tap anywhere to input mood',
            style: TextStyle(color: Colors.white70, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
