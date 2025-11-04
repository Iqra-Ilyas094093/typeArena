class BracketHelper {
  static const Map<String, String> _openingToClosing = {
    '(': ')',
    '{': '}',
    '[': ']',
  };

  static const Map<String, String> _closingToOpening = {
    ')': '(',
    '}': '{',
    ']': '[',
  };

  static bool isOpeningBracket(String char) {
    return _openingToClosing.containsKey(char);
  }

  static bool isClosingBracket(String char) {
    return _closingToOpening.containsKey(char);
  }

  static String? getClosingBracket(String opening) {
    return _openingToClosing[opening];
  }

  static String? getOpeningBracket(String closing) {
    return _closingToOpening[closing];
  }

  static bool isMatchingPair(String opening, String closing) {
    return _openingToClosing[opening] == closing;
  }
}