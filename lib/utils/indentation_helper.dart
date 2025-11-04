class IndentationHelper {
  static int calculateIndentationLevel(String line) {
    int level = 0;
    for (int i = 0; i < line.length; i++) {
      if (line[i] == ' ' || line[i] == '\t') {
        if (line[i] == '\t') level++;
      } else {
        break;
      }
    }
    return level;
  }

  static String getIndentationString(int level, {bool useTabs = false}) {
    if (useTabs) {
      return '\t' * level;
    }
    return '  ' * level;
  }

  static bool shouldIncreaseIndentation(String line) {
    return line.trim().endsWith('{') ||
        line.trim().endsWith('(') ||
        line.contains('=>') && !line.trim().endsWith(';');
  }
}