import '../model/typing_session.dart';

class TypingMetrics {
  final int totalCharacters;
  final int correctCharacters;
  final int errors;
  final Duration duration;
  final bool isCompleted;

  TypingMetrics({
    required this.totalCharacters,
    required this.correctCharacters,
    required this.errors,
    required this.duration,
    required this.isCompleted,
  });

  double get accuracy {
    if (totalCharacters == 0) return 0;
    return (correctCharacters / totalCharacters) * 100;
  }

  double get wpm {
    double words = totalCharacters / 5;
    double minutes = duration.inSeconds / 60;
    return minutes > 0 ? words / minutes : 0;
  }

  double get cpm {
    double minutes = duration.inSeconds / 60;
    return minutes > 0 ? totalCharacters / minutes : 0;
  }

  double get progress {
    return totalCharacters > 0 ? correctCharacters / totalCharacters : 0;
  }
}

class MetricsCalculator {
  static TypingMetrics calculateMetrics(TypingSession session) {
    return TypingMetrics(
      totalCharacters: session.totalCharacters,
      correctCharacters: session.correctCharacters,
      errors: session.errors,
      duration: session.duration,
      isCompleted: session.isCompleted,
    );
  }
}