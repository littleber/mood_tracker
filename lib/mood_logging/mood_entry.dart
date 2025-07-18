class MoodEntry {
  final int mood;
  final DateTime timestamp;

  MoodEntry({required this.mood, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'mood': mood,
    'timestamp': timestamp.toIso8601String(),
  };

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      mood: json['mood'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
