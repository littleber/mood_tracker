// // Flutter framework for UI
// import 'package:flutter/material.dart';

// // Custom imports for mood storage and model
// import 'mood_storage.dart';
// import 'mood_entry.dart';

// // Stateless widget: This screen does not manage state internally
// class MoodHistoryScreen extends StatelessWidget {
//   const MoodHistoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Sets the background color of the entire screen
//       backgroundColor: Colors.grey[900],

//       // App bar at the top of the screen
//       appBar: AppBar(
//         backgroundColor: Colors.grey[850], // dark app bar background
//         foregroundColor: Colors.white,     // makes back arrow and title white
//         title: const Text('Mood History'), // title in the app bar
//       ),

//       // Body of the screen uses FutureBuilder to wait for async data
//       body: FutureBuilder<List<MoodEntry>>(
//         future: MoodStorage.loadMoods(), // loads saved mood entries
//         builder: (context, snapshot) {
//           // While loading, show a progress spinner
//           if (snapshot.connectionState != ConnectionState.done) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // Extract mood list (or empty list if null)
//           final moods = snapshot.data ?? [];

//           // If no moods have been saved yet, show placeholder message
//           if (moods.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No moods logged yet.",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             );
//           }

//           // If moods exist, display them in a scrollable list
//           return ListView.builder(
//             itemCount: moods.length, // how many list items
//             itemBuilder: (context, index) {
//               final entry = moods[index];

//               // Format the timestamp (e.g., 2025-07-18 14:32)
//               final time = entry.timestamp.toLocal().toString().substring(0, 16);

//               // Get corresponding emoji for mood rating
//               final emoji = _getEmoji(entry.mood);

//               // Display each mood entry with emoji, mood rating, and timestamp
//               return ListTile(
//                 title: Text(
//                   '$emoji Mood: ${entry.mood}',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 subtitle: Text(
//                   time,
//                   style: const TextStyle(color: Colors.white54),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Maps a mood rating (1–10) to an emoji
//   String _getEmoji(int mood) {
//     const emojiMap = {
//       1: '😭', 2: '😢', 3: '😞', 4: '😕', 5: '😐',
//       6: '🙂', 7: '😊', 8: '😁', 9: '😄', 10: '🤩',
//     };
//     return emojiMap[mood] ?? '❓'; // fallback emoji if out of range
//   }
// }
