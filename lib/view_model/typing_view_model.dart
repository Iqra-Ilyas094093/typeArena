import 'dart:async';
import 'package:flutter/material.dart';
import '../model/code_snippet.dart';
import '../model/typing_session.dart';
import '../utils/bracket helpers.dart';
import '../utils/code_parser.dart';
import '../utils/indentation_helper.dart';
import '../utils/metrics_calculator.dart';

class TypingViewModel with ChangeNotifier {
  late TypingSession _session;
  final List<CodeToken> _tokens = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int _cursorPosition = 0;
  bool _isCompleted = false;
  Timer? _timer;
  DateTime? _sessionStartTime;
  List<TypingEvent> _typingEvents = [];

  TypingViewModel(CodeSnippet snippet) {
    _session = TypingSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      snippet: snippet,
      startTime: DateTime.now(),
      events: [],
    );
    _tokens.addAll(CodeParser.parseCode(snippet.code));
    _startTimer();
  }

  // Getters
  String get originalCode => _session.snippet.code;
  List<CodeToken> get tokens => _tokens;
  int get cursorPosition => _cursorPosition;
  bool get isCompleted => _isCompleted;
  TextEditingController get textController => _textController;
  FocusNode get focusNode => _focusNode;
  List<TypingEvent> get typingEvents => _typingEvents;

  TypingMetrics get metrics {
    final duration = _sessionStartTime != null
        ? DateTime.now().difference(_sessionStartTime!)
        : const Duration(seconds: 0);

    return TypingMetrics(
      totalCharacters: originalCode.length,
      correctCharacters: _typingEvents.where((e) => e.isCorrect).length,
      errors: _typingEvents.where((e) => !e.isCorrect).length,
      duration: duration,
      isCompleted: _isCompleted,
    );
  }

  int get secondsElapsed {
    return _sessionStartTime != null
        ? DateTime.now().difference(_sessionStartTime!).inSeconds
        : 0;
  }

  void _startTimer() {
    _sessionStartTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  void handleTextChange(String text) {
    if (_isCompleted) return;

    int newPosition = _textController.selection.baseOffset;

    // Prevent skipping ahead
    if (newPosition > _cursorPosition + 1) {
      _textController.text = _textController.text.substring(0, _cursorPosition);
      _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
      return;
    }

    // Handle character typing
    if (newPosition == _cursorPosition + 1) {
      _handleCharacterTyped(text);
    }
    // Handle backspace
    else if (newPosition == _cursorPosition - 1) {
      _handleBackspace();
    }

    _cursorPosition = _textController.selection.baseOffset;
    _checkCompletion();
    notifyListeners();
  }

  void _handleCharacterTyped(String text) {
    if (_cursorPosition >= originalCode.length) return;

    String typedChar = text[_cursorPosition];
    String expectedChar = originalCode[_cursorPosition];
    bool isCorrect = typedChar == expectedChar;

    // Record event for the typed character
    _typingEvents.add(TypingEvent(
      position: _cursorPosition,
      typedChar: typedChar,
      expectedChar: expectedChar,
      timestamp: DateTime.now(),
      isCorrect: isCorrect,
    ));

    // Auto-close brackets only if correct
    if (isCorrect && BracketHelper.isOpeningBracket(typedChar)) {
      _handleAutoCloseBracket(typedChar);
    }
    // Smart bracket skipping
    else if (BracketHelper.isClosingBracket(typedChar) &&
        isCorrect &&
        _cursorPosition + 1 < originalCode.length &&
        originalCode[_cursorPosition + 1] == typedChar) {
      _cursorPosition++;
      _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
    }

    // Auto-indent after {
    if (isCorrect && typedChar == '{') {
      _handleAutoIndent();
    }
  }

  void _handleAutoCloseBracket(String openingBracket) {
    final closingBracket = BracketHelper.getClosingBracket(openingBracket);
    if (closingBracket != null) {
      // Check if there's a matching closing bracket in the original code
      if (_cursorPosition + 1 < originalCode.length &&
          originalCode[_cursorPosition + 1] == closingBracket) {

        // 1. AUTO-INSERT closing bracket in typed text
        final currentText = _textController.text;
        final newText = '${currentText.substring(0, _cursorPosition + 1)}$closingBracket${currentText.substring(_cursorPosition + 1)}';
        _textController.text = newText;

        // 2. MARK BOTH BRACKETS AS TYPED in snippet (so they show as white)
        _typingEvents.add(TypingEvent(
          position: _cursorPosition,
          typedChar: openingBracket,
          expectedChar: openingBracket,
          timestamp: DateTime.now(),
          isCorrect: true,
        ));
        _typingEvents.add(TypingEvent(
          position: _cursorPosition + 1,
          typedChar: closingBracket,
          expectedChar: closingBracket,
          timestamp: DateTime.now(),
          isCorrect: true,
        ));

        // 3. MOVE CURSOR BETWEEN brackets so you can type content
        _cursorPosition++;
        _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
      } else {
        // If no closing bracket in original, just insert normally
        final currentText = _textController.text;
        final newText = '${currentText.substring(0, _cursorPosition + 1)}$closingBracket${currentText.substring(_cursorPosition + 1)}';
        _textController.text = newText;
        _cursorPosition++;
        _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
      }
    }
  }
  void _handleAutoIndent() {
    final lines = _textController.text.split('\n');
    if (lines.isEmpty) return;

    final currentLine = lines.last;
    final indentLevel = IndentationHelper.calculateIndentationLevel(currentLine);
    final indentString = IndentationHelper.getIndentationString(indentLevel + 1);

    final currentText = _textController.text;
    final newText = '$currentText\n$indentString';
    _textController.text = newText;
    _cursorPosition = newText.length;
    _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
  }

  void _handleBackspace() {
    if (_typingEvents.isNotEmpty && _typingEvents.last.position == _cursorPosition - 1) {
      _typingEvents.removeLast();
    }
  }

  void _checkCompletion() {
    if (_cursorPosition >= originalCode.length) {
      _isCompleted = true;
      _session.isCompleted = true;
      _session.endTime = DateTime.now();
      _timer?.cancel();
    }
  }

  void moveCursorLeft() {
    if (_cursorPosition > 0) {
      _cursorPosition--;
      _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
      notifyListeners();
    }
  }

  void moveCursorRight() {
    if (_cursorPosition < _textController.text.length && _cursorPosition < originalCode.length) {
      _cursorPosition++;
      _textController.selection = TextSelection.collapsed(offset: _cursorPosition);
      notifyListeners();
    }
  }

  void resetSession() {
    _timer?.cancel();
    _textController.clear();
    _cursorPosition = 0;
    _isCompleted = false;
    _typingEvents.clear();
    _session = TypingSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      snippet: _session.snippet,
      startTime: DateTime.now(),
      events: [],
    );
    _startTimer();
    notifyListeners();
  }

  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}