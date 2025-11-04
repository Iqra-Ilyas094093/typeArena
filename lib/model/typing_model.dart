class TypedLine {
  final String original;
  final List<TypedChar> chars;

  TypedLine({required this.original})
      : chars = List.generate(
      original.length, (index) => TypedChar(char: original[index]));

  void setCharAt(int index, bool isCorrect) {
    if (index < chars.length) {
      chars[index] = TypedChar(char: original[index], isTyped: true, isCorrect: isCorrect);
    }
  }
}

class TypedChar {
  final String char;
  bool isTyped;
  bool isCorrect;

  TypedChar({required this.char, this.isTyped = false, this.isCorrect = false});
}
