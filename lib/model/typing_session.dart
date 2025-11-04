import 'code_snippet.dart';

class TypingSession {
  final String sessionId;
  final CodeSnippet snippet;
  final DateTime startTime;
  DateTime? endTime;
  final List<TypingEvent> events;
  int currentPosition;
  int errors;
  bool isCompleted;

  TypingSession({
    required this.sessionId,
    required this.snippet,
    required this.startTime,
    this.endTime,
    required this.events,
    this.currentPosition = 0,
    this.errors = 0,
    this.isCompleted = false,
  });

  int get totalCharacters => snippet.code.length;
  int get correctCharacters => events.where((e) => e.isCorrect).length;
  double get accuracy => totalCharacters > 0 ? correctCharacters / totalCharacters * 100 : 0;
  Duration get duration => endTime != null
      ? endTime!.difference(startTime)
      : DateTime.now().difference(startTime);
}

class TypingEvent {
  final int position;
  final String typedChar;
  final String expectedChar;
  final DateTime timestamp;
  final bool isCorrect;

  TypingEvent({
    required this.position,
    required this.typedChar,
    required this.expectedChar,
    required this.timestamp,
    required this.isCorrect,
  });
}