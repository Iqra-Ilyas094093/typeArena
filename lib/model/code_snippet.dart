class CodeSnippet {
  final String id;
  final String language;
  final String code;
  final String title;
  final Difficulty difficulty;

  CodeSnippet({
    required this.id,
    required this.language,
    required this.code,
    required this.title,
    required this.difficulty,
  });
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
}