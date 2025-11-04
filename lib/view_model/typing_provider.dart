import 'package:flutter/material.dart';
import '../model/code_snippet.dart';
import 'typing_view_model.dart';

class TypingProvider with ChangeNotifier {
  TypingViewModel? _typingViewModel;

  TypingViewModel? get typingViewModel => _typingViewModel;

  void initializeTypingSession(CodeSnippet snippet) {
    _typingViewModel?.dispose();
    _typingViewModel = TypingViewModel(snippet);
    notifyListeners();
  }

  void disposeViewModel() {
    _typingViewModel?.dispose();
    _typingViewModel = null;
  }
}