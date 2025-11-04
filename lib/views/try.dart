import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view_model/typing_view_model.dart';

class TypingPracticePage extends StatefulWidget {
  const TypingPracticePage({super.key});

  @override
  State<TypingPracticePage> createState() => _TypingPracticePageState();
}

class _TypingPracticePageState extends State<TypingPracticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
      body: Consumer<TypingViewModel>(
        builder: (context, viewModel, child) {
          final metrics = viewModel.metrics;
          final seconds = viewModel.secondsElapsed;

          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF283339)),
                  ),
                ),
                child: Row(
                  children: [
                    // Logo and Title
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1193D4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.code,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'CodeType',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.015,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Action Buttons
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle change exercise
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF283339)),
                            backgroundColor: const Color(0x0DFFFFFF),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.code, size: 16),
                          label: Text(
                            'Change Exercise',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: viewModel.resetSession,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1193D4),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.refresh, size: 16),
                          label: Text(
                            'Reset',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.015,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page Title
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'JavaScript - Palindrome Check',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.033,
                          ),
                        ),
                      ),
                      // Status Bar
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFF283339)),
                            bottom: BorderSide(color: Color(0xFF283339)),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildStatItem(metrics.wpm.round().toString(), 'WPM', isPrimary: true),
                            _buildStatItem(metrics.cpm.round().toString(), 'CPM'),
                            _buildStatItem(metrics.errors.toString(), 'Errors'),
                            const Spacer(),
                            _buildStatItem(_formatTime(seconds), 'Time'),
                          ],
                        ),
                      ),
                      // Progress Bar
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${(metrics.progress * 100).round()}%',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: const Color(0xFF9DB0B9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: metrics.progress,
                              backgroundColor: const Color(0xFF3B4B54),
                              color: const Color(0xFF1193D4),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                      // Code Display Panel
                      _buildCodeDisplay(viewModel),
                      // User Input Panel
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C2327),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF3B4B54)),
                        ),
                        child: TextField(
                          controller: viewModel.textController,
                          focusNode: viewModel.focusNode,
                          maxLines: 10,
                          minLines: 10,
                          decoration: InputDecoration(
                            hintText: 'Start typing here...',
                            hintStyle: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(24),
                          ),
                          style: GoogleFonts.firaCode(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          onChanged: viewModel.handleTextChange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCodeDisplay(TypingViewModel viewModel) {
    final typedText = viewModel.textController.text;
    final originalCode = viewModel.originalCode;
    final cursorPosition = viewModel.cursorPosition;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2327),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _buildRichCodeText(originalCode, typedText, cursorPosition),
    );
  }

  Widget _buildRichCodeText(String originalCode, String typedText, int cursorPosition) {
    final children = <TextSpan>[];

    for (int i = 0; i < originalCode.length; i++) {
      final char = originalCode[i];
      final isTyped = i < typedText.length;
      final isCurrent = i == cursorPosition;
      final isCorrect = isTyped && typedText[i] == char;

      Color color;
      if (isCurrent) {
        color = const Color(0xFF1193D4);
      } else if (isTyped) {
        color = isCorrect ? Colors.white : Colors.red;
      } else {
        color = const Color(0xFF9DB0B9).withOpacity(0.5);
      }

      // Basic syntax highlighting
      if (i < originalCode.length - 8 && originalCode.substring(i, i + 8) == 'function') {
        color = const Color(0xFF569CD6);
      } else if (i < originalCode.length - 6 && originalCode.substring(i, i + 6) == 'return') {
        color = const Color(0xFFC586C0);
      } else if (i < originalCode.length - 3 && originalCode.substring(i, i + 3) == 'str') {
        color = const Color(0xFF9CDCFE);
      } else if (char == '(' || char == ')' || char == '{' || char == '}' || char == ';' || char == '.') {
        color = const Color(0xFF9DB0B9);
      } else if (char == "'") {
        color = const Color(0xFFCE9178);
      }

      children.add(TextSpan(
        text: char,
        style: GoogleFonts.firaCode(
          color: color,
          fontSize: 16,
          backgroundColor: isCurrent ? const Color(0xFF1193D4).withOpacity(0.2) : Colors.transparent,
        ),
      ));
    }

    return SelectableText.rich(
      TextSpan(children: children),
      style: GoogleFonts.firaCode(height: 1.5),
    );
  }

  Widget _buildStatItem(String value, String label, {bool isPrimary = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: isPrimary ? const Color(0xFF1193D4) : Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF9DB0B9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}