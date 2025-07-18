// Import the Flutter material design package
import 'package:flutter/material.dart';

// Confirmation screen shown after submitting a mood
class ConfirmationScreen extends StatelessWidget {
  // Final field to hold the emoji passed in from the previous screen
  final String moodEmoji;

  // Constructor with a required named parameter for moodEmoji
  const ConfirmationScreen({Key? key, required this.moodEmoji}) : super(key: key);

  // The build method describes how the widget appears
  @override
  Widget build(BuildContext context) {
    // Schedule a delayed function to go back to the previous screen after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    // UI structure
    return Scaffold(
      backgroundColor: Colors.grey[850], // Dark background color

      // Centered content on the screen
      body: Center(
        child: Text(
          'Thanks! You selected:\n$moodEmoji',  // Text message + selected emoji
          style: const TextStyle(
            fontSize: 48,              // Large font for visibility
            color: Colors.white,       // Set text color to white
          ),
          textAlign: TextAlign.center, // Center-align text within the box
        ),
      ),
    );
  }
}
