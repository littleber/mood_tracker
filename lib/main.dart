import 'package:flutter/material.dart';
import 'start/idle_screen.dart';  // import your idle screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      home: const IdleScreen(),  // Start from IdleScreen
    );
  }
}
