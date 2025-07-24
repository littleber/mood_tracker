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
      body: Stack(
        children: [
          // 1) Full‑screen tap area
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final mood = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MoodInputScreen()),
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
                style: const TextStyle(color: Colors.white, fontSize: 36),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // 2) Circular button in top-right corner
          Positioned(
            top: 30,
            right: 15,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/analytics'),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.grid_on, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}