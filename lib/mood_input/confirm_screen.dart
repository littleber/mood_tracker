import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final String moodEmoji;

  const ConfirmationScreen({Key? key, required this.moodEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // After 5 seconds, automatically go back to the previous screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context, moodEmoji);  // Return mood emoji when popping
    });

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Text(
          'Thanks! You selected:\n$moodEmoji',
          style: const TextStyle(fontSize: 48),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
