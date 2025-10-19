import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingSettingsPage extends StatefulWidget {
  const TypingSettingsPage({super.key});

  @override
  State<TypingSettingsPage> createState() => _TypingSettingsPageState();
}

class _TypingSettingsPageState extends State<TypingSettingsPage> {
  String _selectedKeyboardLayout = 'QWERTY';
  bool _keyPressSound = false;
  String _selectedSoundType = 'Click';
  bool _highlightErrors = true;
  bool _autoCompletion = false;

  final Map<String, bool> _syntaxHighlighting = {
    'JavaScript': true,
    'Python': true,
    'C++': false,
    'HTML': false,
    'CSS': false,
    'Java': false,
  };

  final List<String> _keyboardLayouts = [
    'QWERTY',
    'Dvorak',
    'Colemak',
  ];

  final List<String> _soundTypes = [
    'Click',
    'Beep',
    'None',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
                    // Logo
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.code,
                        color: Color(0xFF101C22),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Typing Tutor',
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
                // Navigation Links
                Row(
                  children: [
                    _buildNavLink('Home'),
                    _buildNavLink('Practice'),
                    _buildNavLink('Profile'),
                    _buildActiveNavLink('Settings'),
                  ],
                ),
                const SizedBox(width: 32),
                // Auth Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        // Handle sign up
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF283339)),
                        backgroundColor: const Color(0xFF283339),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
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
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      'Typing Settings',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.033,
                      ),
                    ),
                  ),
                  // Keyboard Layout Section
                  _buildSection(
                    title: 'Keyboard Layout',
                    child: SizedBox(
                      width: 480,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Layout',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedKeyboardLayout,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedKeyboardLayout = newValue!;
                              });
                            },
                            dropdownColor: const Color(0xFF1C2327),
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF1C2327),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFF3B4B54)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFF3B4B54)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFF4A90E2)),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            items: _keyboardLayouts.map((String layout) {
                              return DropdownMenuItem<String>(
                                value: layout,
                                child: Text(layout),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Sound & Visuals Section
                  _buildSection(
                    title: 'Sound & Visuals',
                    child: Column(
                      children: [
                        // Key Press Sound Toggle
                        _buildToggleSetting(
                          title: 'Key Press Sound',
                          value: _keyPressSound,
                          onChanged: (value) {
                            setState(() {
                              _keyPressSound = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        // Sound Type Selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sound Type',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: _soundTypes.map((soundType) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 24),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: soundType,
                                        groupValue: _selectedSoundType,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedSoundType = value!;
                                          });
                                        },
                                        activeColor: const Color(0xFF4A90E2),
                                      ),
                                      Text(
                                        soundType,
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Highlight Errors Toggle
                        _buildToggleSetting(
                          title: 'Highlight Errors',
                          value: _highlightErrors,
                          onChanged: (value) {
                            setState(() {
                              _highlightErrors = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Coding Practice Section
                  _buildSection(
                    title: 'Coding Practice',
                    child: Column(
                      children: [
                        // Syntax Highlighting Checkboxes
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enable Syntax Highlighting',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3,
                              children: _syntaxHighlighting.entries.map((entry) {
                                return CheckboxListTile(
                                  title: Text(
                                    entry.key,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  value: entry.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _syntaxHighlighting[entry.key] = value!;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: const Color(0xFF4A90E2),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Auto-Completion Toggle
                        _buildToggleSetting(
                          title: 'Enable Auto-Completion Suggestions',
                          value: _autoCompletion,
                          onChanged: (value) {
                            setState(() {
                              _autoCompletion = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons
                  Container(
                    margin: const EdgeInsets.only(top: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _resetToDefaults();
                          },
                          child: Text(
                            'Reset to Defaults',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFFF5A623),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            _saveChanges();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7ED321),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.015,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildNavLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActiveNavLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          color: const Color(0xFF4A90E2),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.015,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF4A90E2),
          activeTrackColor: const Color(0xFF4A90E2).withOpacity(0.5),
        ),
      ],
    );
  }

  void _resetToDefaults() {
    setState(() {
      _selectedKeyboardLayout = 'QWERTY';
      _keyPressSound = false;
      _selectedSoundType = 'Click';
      _highlightErrors = true;
      _autoCompletion = false;
      _syntaxHighlighting.updateAll((key, value) {
        return key == 'JavaScript' || key == 'Python';
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Settings reset to defaults',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }

  void _saveChanges() {
    // Save settings logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Settings saved successfully!',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF7ED321),
      ),
    );
  }
}