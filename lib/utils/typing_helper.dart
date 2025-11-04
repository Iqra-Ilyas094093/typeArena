// typing_helper.dart
class TypingToken {
  final String char;
  final bool isBracket;
  final bool isOpeningBracket;
  final int indentLevel;

  TypingToken({
    required this.char,
    this.isBracket = false,
    this.isOpeningBracket = false,
    this.indentLevel = 0,
  });
}

class TypingHelper {
  List<TypingToken> parseCode(String code) {
    final List<TypingToken> tokens = [];
    int indentLevel = 0;

    for (int i = 0; i < code.length; i++) {
      final char = code[i];

      if (char == '{') {
        tokens.add(TypingToken(char: char, isBracket: true, isOpeningBracket: true, indentLevel: indentLevel));
        indentLevel++;
      } else if (char == '}') {
        indentLevel = indentLevel > 0 ? indentLevel - 1 : 0;
        tokens.add(TypingToken(char: char, isBracket: true, isOpeningBracket: false, indentLevel: indentLevel));
      } else if (char == '(' || char == '[') {
        tokens.add(TypingToken(char: char, isBracket: true, isOpeningBracket: true, indentLevel: indentLevel));
      } else if (char == ')' || char == ']') {
        tokens.add(TypingToken(char: char, isBracket: true, isOpeningBracket: false, indentLevel: indentLevel));
      } else {
        tokens.add(TypingToken(char: char, indentLevel: indentLevel));
      }
    }

    return tokens;
  }

  bool shouldAutoCloseBracket(String typedChar) {
    return typedChar == '(' || typedChar == '{' || typedChar == '[';
  }

  String getMatchingBracket(String opening) {
    switch (opening) {
      case '(':
        return ')';
      case '{':
        return '}';
      case '[':
        return ']';
      default:
        return '';
    }
  }

  bool isBlockStart(TypingToken token) {
    return token.char == '{' && token.isOpeningBracket;
  }

  int getIndentLevel(int index, List<TypingToken> tokens) {
    return tokens[index].indentLevel;
  }
}
