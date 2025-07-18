// Importing the Flutter material design library
import 'package:flutter/material.dart';

// Importing your MoodInput screen (the screen user navigates to on tap)
import '../mood_input/mood_input_screen.dart';

// This is a stateless widget — no internal state changes, so it doesn't need to rebuild itself dynamically
class IdleScreen extends StatelessWidget {
  // Constructor with optional key, used for widget identification (Flutter optimization)
  const IdleScreen({Key? key}) : super(key: key);

  // The `build` method describes the UI for this screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1) Tap-to-log area
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final mood = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MoodInputScreen(),
                      ),
                    );
                    if (mood != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mood submitted: $mood')),
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      'Tap anywhere to input mood',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
  
              const SizedBox(height: 24),
  
              // 2) View History button
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text('View Mood History'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
              ),
  
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
