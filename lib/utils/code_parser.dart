import 'bracket helpers.dart';

class CodeToken {
  final String character;
  final int position;
  final bool isBracket;
  final bool isWhitespace;
  final int lineNumber;
  final int columnNumber;

  CodeToken({
    required this.character,
    required this.position,
    required this.isBracket,
    required this.isWhitespace,
    required this.lineNumber,
    required this.columnNumber,
  });
}

class CodeParser {
  static List<CodeToken> parseCode(String code) {
    List<CodeToken> tokens = [];
    List<String> lines = code.split('\n');
    int position = 0;

    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      String line = lines[lineIndex];

      for (int charIndex = 0; charIndex < line.length; charIndex++) {
        String char = line[charIndex];
        tokens.add(CodeToken(
          character: char,
          position: position,
          isBracket: BracketHelper.isOpeningBracket(char) || BracketHelper.isClosingBracket(char),
          isWhitespace: char == ' ' || char == '\t',
          lineNumber: lineIndex,
          columnNumber: charIndex,
        ));
        position++;
      }

      if (lineIndex < lines.length - 1) {
        tokens.add(CodeToken(
          character: '\n',
          position: position,
          isBracket: false,
          isWhitespace: true,
          lineNumber: lineIndex,
          columnNumber: line.length,
        ));
        position++;
      }
    }

    return tokens;
  }
}