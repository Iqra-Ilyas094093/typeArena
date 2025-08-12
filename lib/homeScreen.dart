// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(home: TypingTestScreen(), debugShowCheckedModeBanner: false));
}

class TypingTestScreen extends StatefulWidget {
  const TypingTestScreen({super.key});
  @override
  State<TypingTestScreen> createState() => _TypingTestScreenState();
}

class _TypingTestScreenState extends State<TypingTestScreen> {
  // --- CONFIG ---
  static const int testDurationSeconds = 60;
  static const int idlePauseSeconds = 5;
  final FocusNode _focusNode = FocusNode();

  // Replace curly quotes with straight ones to avoid apostrophe mismatch
  final String _rawParagraph = """
Flutter is Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It's loved for its fast development, expressive UI, and native performance. Developers use the Dart language to create Flutter apps, enjoying hot reload and a rich set of widgets. Keep typing until the timer ends.
""";

  // --- STATE ---
  late String paragraph; // normalized paragraph
  late List<bool> wasMistyped; // per-char: ever mistyped and not corrected by backspace
  late List<int> currentTypedState; // -1 = not typed, 0 = typed incorrect now, 1 = typed correct now
  late Map<String, int> wrongPressCounts; // char -> times pressed wrong
  int currentIndex = 0;

  // Timer and idle
  Timer? countdownTimer;
  Timer? idleTimer;
  int secondsLeft = testDurationSeconds;
  bool timerStarted = false;
  bool isPaused = false;

  // Stats caches (computed at the end)
  int correctWords = 0;
  int wrongWords = 0;
  int completedWords = 0;

  @override
  void initState() {
    super.initState();
    // normalize paragraph (straight quotes, plain whitespace)
    paragraph = _normalizeQuotes(_rawParagraph);
    wasMistyped = List<bool>.filled(paragraph.length, false);
    currentTypedState = List<int>.filled(paragraph.length, -1);
    wrongPressCounts = {};
    // autofocus
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    idleTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  // Normalize curly quotes to straight quotes and unify whitespace
  String _normalizeQuotes(String s) {
    return s
        .replaceAll('\u2018', "'")
        .replaceAll('\u2019', "'")
        .replaceAll('\u201C', '"')
        .replaceAll('\u201D', '"')
        .replaceAll('\u2013', '-') // en dash
        .replaceAll('\u2014', '-') // em dash
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  // Normalize incoming character (map curly to straight)
  String _normalizeChar(String ch) {
    if (ch == '\u2019' || ch == '\u2018') return "'";
    if (ch == '\u201C' || ch == '\u201D') return '"';
    return ch;
  }

  // Start timer on first keypress
  void _startTimerIfNeeded() {
    if (timerStarted) return;
    timerStarted = true;
    isPaused = false;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!isPaused) {
        setState(() {
          if (secondsLeft > 0) {
            secondsLeft--;
          } else {
            t.cancel();
            _finishTest();
          }
        });
      }
    });
    _resetIdleTimer();
  }

  // Idle timer resets on every processed key (pauses after idlePauseSeconds)
  void _resetIdleTimer() {
    idleTimer?.cancel();
    idleTimer = Timer(const Duration(seconds: idlePauseSeconds), () {
      if (!mounted) return;
      setState(() {
        isPaused = true;
      });
    });
  }

  // When key press occurs while paused, resume and process the key
  void _resumeFromPause() {
    if (isPaused) {
      setState(() => isPaused = false);
      _resetIdleTimer();
    }
  }

  // Handle key events using Focus.onKeyEvent (non-deprecated)
  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    // Only handle key down events
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    // Determine printable character (handle space and visible chars)
    String ch = '';
    if (event.logicalKey == LogicalKeyboardKey.space) {
      ch = ' ';
    } else if (event.character != null && event.character!.isNotEmpty) {
      ch = _normalizeChar(event.character!);
    } else {
      // ignore non-printable (shift, ctrl, etc.)
    }

    // Backspace handling
    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      // If we're at 0, nothing to do
      if (currentIndex > 0) {
        setState(() {
          currentIndex--;
          // clearing a previously mistyped position removes its wasMistyped status
          // (user explicitly corrected via backspace)
          wasMistyped[currentIndex] = false;
          currentTypedState[currentIndex] = -1;
        });
      }
      // reset idle timer and resume if paused
      _resumeFromPause();
      _resetIdleTimer();
      return KeyEventResult.handled;
    }

    // If char is empty (non-printable) do nothing
    if (ch.isEmpty) return KeyEventResult.handled;

    // start timer on first printable key
    if (!timerStarted) _startTimerIfNeeded();

    // if paused, resume first and still process this key
    if (isPaused) {
      _resumeFromPause();
    }

    // reset idle timer
    _resetIdleTimer();

    // If test already finished, ignore
    if (secondsLeft <= 0) return KeyEventResult.handled;

    // Guard: if currentIndex beyond paragraph, ignore
    if (currentIndex >= paragraph.length) return KeyEventResult.handled;

    final expected = paragraph[currentIndex];

    // If pressed char doesn't match expected char => mark as mistyped here
    if (ch != expected) {
      // record wrong press for this character key
      wrongPressCounts[ch] = (wrongPressCounts[ch] ?? 0) + 1;

      // mark this index as mistyped (will remain true until user backspaces over it)
      setState(() {
        wasMistyped[currentIndex] = true;
        currentTypedState[currentIndex] = 0; // typed incorrect now
      });
      // Do NOT advance index — user must type the correct char (or backspace to correct)
      return KeyEventResult.handled;
    }

    // ch == expected (correct press)
    setState(() {
      // mark current index as correct typed now
      currentTypedState[currentIndex] = 1;
      // advance index
      currentIndex++;
    });

    return KeyEventResult.handled;
  }

  // When time finishes or user stops, compute word-level stats and show dialog
  void _finishTest() {
    // compute per-word correctness: a word is considered completed when the user has typed past
    // its last character (i.e., currentIndex > lastIndexOfWord) OR when test ended and user typed entire paragraph.
    final wordsRanges = _wordRanges(paragraph);
    int cWords = 0, wWords = 0, completed = 0;

    for (final r in wordsRanges) {
      final lastIdx = r.end;
      bool completedWord = currentIndex > lastIdx; // user typed past the space ending word
      // for last word if user typed entire paragraph, also completed
      if (!completedWord && currentIndex >= paragraph.length) completedWord = true;
      if (!completedWord) continue;

      completed++;
      bool anyMistypedInWord = false;
      for (int i = r.start; i <= r.end && i < wasMistyped.length; i++) {
        if (wasMistyped[i]) {
          anyMistypedInWord = true;
          break;
        }
      }
      if (anyMistypedInWord) wWords++; else cWords++;
    }

    // compute totals
    setState(() {
      correctWords = cWords;
      wrongWords = wWords;
      completedWords = completed;
    });

    final minutes = (testDurationSeconds - secondsLeft) / 60.0;
    final grossWpm = minutes > 0 ? completedWords / minutes : 0.0;
    final netWpm = minutes > 0 ? correctWords / minutes : 0.0;
    final totalTypedChars = currentTypedState.where((s) => s != -1).length;
    final totalMistypedPositions = wasMistyped.where((b) => b).length;
    final accuracy = completedWords > 0 ? (correctWords / completedWords) * 100.0 : 0.0;

    // find common problem keys (> 2 wrong presses)
    final commonProblems = wrongPressCounts.entries.where((e) => e.value > 2).toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Test Results'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Time taken: ${testDurationSeconds - secondsLeft}s'),
                const SizedBox(height: 8),
                Text('Total completed words: $completedWords'),
                Text('Correct words: $correctWords'),
                Text('Wrong words: $wrongWords'),
                const SizedBox(height: 8),
                Text('Accuracy (words): ${accuracy.toStringAsFixed(1)}%'),
                const SizedBox(height: 8),
                Text('Gross WPM (words/min): ${grossWpm.toStringAsFixed(1)}'),
                Text('Net WPM (correct words/min): ${netWpm.toStringAsFixed(1)}'),
                const SizedBox(height: 12),
                Text('Total typed chars: $totalTypedChars'),
                Text('Positions ever mistyped: $totalMistypedPositions'),
                const SizedBox(height: 12),
                Text('Common problem keys (mistyped > 2 times):'),
                if (commonProblems.isEmpty)
                  const Padding(padding: EdgeInsets.only(top: 8), child: Text('None'))
                else
                  ...commonProblems.map((e) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(" '${e.key}'  → ${e.value} times"),
                  )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _resetTest();
              },
              child: const Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).maybePop();
              },
              child: const Text('Back Home'),
            ),
          ],
        );
      },
    );
  }

  // Reset everything to start again
  void _resetTest() {
    countdownTimer?.cancel();
    idleTimer?.cancel();
    setState(() {
      secondsLeft = testDurationSeconds;
      timerStarted = false;
      isPaused = false;
      currentIndex = 0;
      wasMistyped = List<bool>.filled(paragraph.length, false);
      currentTypedState = List<int>.filled(paragraph.length, -1);
      wrongPressCounts.clear();
      correctWords = wrongWords = completedWords = 0;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  // Compute ranges of words as start..end char indices
  List<_Range> _wordRanges(String s) {
    final List<_Range> ranges = [];
    int start = -1;
    for (int i = 0; i < s.length; i++) {
      if (s[i] != ' ' && start == -1) {
        start = i;
      } else if (s[i] == ' ' && start != -1) {
        ranges.add(_Range(start, i - 1));
        start = -1;
      }
    }
    if (start != -1) {
      ranges.add(_Range(start, s.length - 1));
    }
    return ranges;
  }

  // Build the visible character widget with underline for current index,
  // color logic: if wasMistyped->red, else if typed correct->green, else neutral
  Widget _buildCharacter(int i, BuildContext context) {
    final isCurrent = i == currentIndex;
    Color color;
    if (wasMistyped[i]) {
      color = Colors.red;
    } else if (currentTypedState[i] == 1) {
      color = Colors.green;
    } else {
      color = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: isCurrent
          ? BoxDecoration(border: Border(bottom: BorderSide(color: isPaused ? Colors.orange : Colors.blue, width: 3)))
          : null,
      child: Text(paragraph[i], style: TextStyle(fontSize: 18, fontFamily: 'monospace', color: color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = secondsLeft / testDurationSeconds;
    final counts = _charCounts();

    return Scaffold(
      appBar: AppBar(title: const Text('TypeArena — Typing Test')),
      body: SafeArea(
        child: Focus(
          focusNode: _focusNode,
          onKeyEvent: _onKey,
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Circular progress/timer
              SizedBox(
                height: 92,
                width: 92,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    Center(
                      child: Text(
                        '${(secondsLeft ~/ 60).toString().padLeft(1, '0')}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              if (!timerStarted) const Text('Press any key to start', style: TextStyle(color: Colors.grey)),
              if (isPaused) const Padding(padding: EdgeInsets.only(top: 8), child: Text('Paused — press any key to resume', style: TextStyle(color: Colors.orange))),
              const SizedBox(height: 12),

              // Paragraph area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: List.generate(paragraph.length, (i) => _buildCharacter(i, context)),
                  ),
                ),
              ),

              // footer stats
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      _tinyStat('Time', '${secondsLeft}s'),
                  const SizedBox(width: 16),

              _tinyStat('Typed', '${counts.totalTyped}'),
              const SizedBox(width: 16),
              _tinyStat('Accuracy', '${counts.accuracy.toStringAsFixed(0)}%'),
            ],
          ),
        ),
        ],
      ),
    ),
    ),
    );
  }

  _CharCounts _charCounts() {
    final typed = currentTypedState.where((s) => s != -1).length;
    final correct = currentTypedState.where((s) => s == 1).length;
    final wrong = wasMistyped.where((b) => b).length;
    final acc = typed > 0 ? (correct / typed) * 100.0 : 100.0;
    return _CharCounts(totalTyped: typed, correct: correct, wrong: wrong, accuracy: acc);
  }

  Widget _tinyStat(String label, String value) {
    return Column(children: [Text(value, style: const TextStyle(fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))]);
  }
}

class _Range {
  final int start, end;
  _Range(this.start, this.end);
}

class _CharCounts {
  final int totalTyped, correct, wrong;
  final double accuracy;
  _CharCounts({required this.totalTyped, required this.correct, required this.wrong, required this.accuracy});
}
