import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:type_arena/views/settings_customization/account_setting.dart';
import 'package:type_arena/views/settings_customization/typing_setting.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkTheme = true;
  double _fontSize = 16.0;
  String _selectedFont = 'Fira Code';
  int _selectedCursorStyle = 0; // 0: Line, 1: Block, 2: Underline

  final List<String> _fontOptions = [
    'Fira Code',
    'JetBrains Mono',
    'Source Code Pro',
    'Inconsolata',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
      body: Row(
        children: [
          // Side Navigation Bar
          Container(
            width: 256,
            decoration: const BoxDecoration(
              color: Color(0xFF1A2830),
              border: Border(
                right: BorderSide(color: Color(0xFF283339)),
              ),
            ),
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.keyboard,
                        color: Color(0xFF1193D4),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'CodeType',
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Navigation Menu
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildNavItem(
                          ontap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage()));
                          },
                          icon: Icons.palette,
                          title: 'Appearance',
                          isActive: true,
                        ),
                        _buildNavItem(
                          ontap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TypingSettingsPage()));
                          },
                          icon: Icons.code,
                          title: 'Typing',
                          isActive: false,
                        ),
                        _buildNavItem(
                          ontap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AccountSettingsPage()));
                          },
                          icon: Icons.person,
                          title: 'Account',
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                ),
                // User Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFF283339)),
                    ),
                  ),
                  child: Column(
                    children: [
                      // User Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDRxZR_t__XydLe-bUjZVNLzexnYy03REx-i9um_oFJQ2LNfwRyTkbLChQvvykmRe0kRo0tLaYmwGTUQyefvJ_5Pzb99Uj_0Q94VLDHJQqHfW3PUT9owkSOLR5bueRD3GOZcvC-Sx7u2jUM4v4Z1NphQpkjEQd0GxVzaWFXPsKC23TsyEzOEeEY0Px9KAOmaveRQVcdGr66PO_4woGNl02JXKPPZBDIlZenbBAam59jAFXXpwJRJM0jjVi_kWEVfY_NBSYdhfEb0v00',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jane Doe',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'jane.doe@example.com',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: const Color(0xFF9DB0B9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Logout Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle logout
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    color: Color(0xFF9DB0B9),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: const Color(0xFF9DB0B9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Header
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appearance',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Customize the look and feel of your typing environment.',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Settings Sections
                    Column(
                      children: [
                        // General Section
                        _buildSection(
                          title: 'General',
                          children: [
                            _buildThemeSetting(),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Text & Font Section
                        _buildSection(
                          title: 'Text',
                          children: [
                            _buildFontSizeSetting(),
                            const Divider(color: Color(0xFF283339)),
                            _buildFontFamilySetting(),
                            const Divider(color: Color(0xFF283339)),
                            _buildCursorStyleSetting(),
                          ],
                        ),
                      ],
                    ),
                    // Action Buttons
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(top: 24),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF283339)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              _resetToDefaults();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF283339)),
                              backgroundColor: const Color(0xFF1A2830),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Reset to Defaults',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              _saveChanges();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1193D4),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required VoidCallback ontap,
    required IconData icon,
    required String title,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0x331193D4) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? const Color(0xFF1193D4)
                      : const Color(0xFF9DB0B9),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: isActive
                        ? const Color(0xFF1193D4)
                        : const Color(0xFF9DB0B9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A2830),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF283339)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSetting() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Switch between light and dark mode.',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF9DB0B9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isDarkTheme,
            onChanged: (value) {
              setState(() {
                _isDarkTheme = value;
              });
            },
            activeColor: const Color(0xFF1193D4),
            activeTrackColor: const Color(0xFF1193D4).withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSetting() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Font Size',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _fontSize,
                        min: 12,
                        max: 24,
                        divisions: 12,
                        onChanged: (value) {
                          setState(() {
                            _fontSize = value;
                          });
                        },
                        activeColor: const Color(0xFF1193D4),
                        inactiveColor: const Color(0xFF283339),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${_fontSize.round()}px',
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF9DB0B9),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFontFamilySetting() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Font Family',
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 200,
            child: DropdownButtonFormField<String>(
              value: _selectedFont,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                });
              },
              dropdownColor: const Color(0xFF1A2830),
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF283339),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items: _fontOptions.map((String font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(font),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCursorStyleSetting() {
    final List<Map<String, dynamic>> cursorStyles = [
      {
        'name': 'Line',
        'widget': Container(
          height: 20,
          width: 2,
          color: const Color(0xFF1193D4),
        ),
      },
      {
        'name': 'Block',
        'widget': Container(
          height: 20,
          width: 10,
          color: const Color(0xFF1193D4).withOpacity(0.8),
        ),
      },
      {
        'name': 'Underline',
        'widget': Container(
          height: 2,
          width: 10,
          color: const Color(0xFF1193D4),
        ),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cursor Style',
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 300,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: List.generate(cursorStyles.length, (index) {
                final style = cursorStyles[index];
                final isSelected = _selectedCursorStyle == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCursorStyle = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1193D4)
                            : const Color(0xFF283339),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? const Color(0x331193D4)
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        style['widget'] as Widget,
                        const SizedBox(height: 8),
                        Text(
                          style['name'],
                          style: GoogleFonts.spaceGrotesk(
                            color: isSelected
                                ? const Color(0xFF1193D4)
                                : const Color(0xFF9DB0B9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    setState(() {
      _isDarkTheme = true;
      _fontSize = 16.0;
      _selectedFont = 'Fira Code';
      _selectedCursorStyle = 0;
    });
  }

  void _saveChanges() {
    // Save settings to persistent storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Settings saved successfully!',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF1193D4),
      ),
    );
  }
}