import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingPracticePage extends StatefulWidget {
  const TypingPracticePage({super.key});

  @override
  State<TypingPracticePage> createState() => _TypingPracticePageState();
}

class _TypingPracticePageState extends State<TypingPracticePage> {
  final TextEditingController _typingController = TextEditingController();
  int _wpm = 65;
  int _cpm = 325;
  int _errors = 3;
  int _seconds = 72;
  double _progress = 0.42;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _typingController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _resetExercise() {
    setState(() {
      _typingController.clear();
      _wpm = 0;
      _cpm = 0;
      _errors = 0;
      _seconds = 0;
      _progress = 0.0;
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
      body: Column(
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
                    // Logo SVG representation
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
                    // Change Exercise Button
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
                    // Reset Button
                    ElevatedButton.icon(
                      onPressed: _resetExercise,
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
                        _buildStatItem('65', 'WPM', isPrimary: true),
                        _buildStatItem('325', 'CPM'),
                        _buildStatItem('3', 'Errors'),
                        const Spacer(),
                        _buildStatItem(_formatTime(_seconds), 'Time'),
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
                              '${(_progress * 100).round()}%',
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
                          value: _progress,
                          backgroundColor: const Color(0xFF3B4B54),
                          color: const Color(0xFF1193D4),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                  // Code Display Panel
                  Container(
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
                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          // Function declaration
                          TextSpan(
                            text: 'function ',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF569CD6),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'isPalindrome',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFDCDCAa),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '(',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'str',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9CDCFE),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ') {\n',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          // Return statement
                          TextSpan(
                            text: '  return ',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFC586C0),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'str',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9CDCFE),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' === ',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          // Highlighted current word
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1193D4).withOpacity(0.2),
                                border: const Border(
                                  left: BorderSide(
                                    color: Color(0xFF1193D4),
                                    width: 2,
                                  ),
                                ),
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(4),
                                ),
                              ),
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                'str',
                                style: GoogleFonts.firaCode(
                                  color: const Color(0xFF9CDCFE),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '.split(',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "''",
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFCE9178),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ').reverse().join(',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "''",
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFCE9178),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ');\n',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '}',
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      style: GoogleFonts.firaCode(
                        height: 1.5,
                      ),
                    ),
                  ),
                  // User Input Panel
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2327),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF3B4B54)),
                    ),
                    child: TextField(
                      controller: _typingController,
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
                      onChanged: (value) {
                        // Update typing metrics
                        setState(() {
                          // This is where you'd calculate real-time metrics
                          _wpm = (value.length / 5).round(); // Simplified WPM calculation
                          _cpm = value.length;
                          _progress = value.length / 100; // Simplified progress
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
}