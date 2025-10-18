import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingSettingsPage extends StatefulWidget {
  const TypingSettingsPage({super.key});

  @override
  State<TypingSettingsPage> createState() => _TypingSettingsPageState();
}

class _TypingSettingsPageState extends State<TypingSettingsPage> {
  String _selectedKeyboardLayout = 'QWERTY';
  bool _soundFeedback = true;
  String _selectedCodingLanguage = 'JavaScript';
  int _selectedTab = 1; // 0: Appearance, 1: Typing, 2: Account

  final List<String> _keyboardLayouts = [
    'QWERTY',
    'Dvorak',
    'Colemak',
  ];

  final List<String> _codingLanguages = [
    'JavaScript',
    'Python',
    'HTML',
    'CSS',
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
                          icon: Icons.palette,
                          title: 'Appearance',
                          isActive: false,
                        ),
                        _buildNavItem(
                          icon: Icons.code,
                          title: 'Typing',
                          isActive: true,
                        ),
                        _buildNavItem(
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
                    // Tabs Navigation
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFF283339)),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildTab('Appearance', 0),
                          _buildTab('Typing', 1),
                          _buildTab('Account', 2),
                        ],
                      ),
                    ),
                    // Settings Sections
                    Column(
                      children: [
                        // Typing Experience Section
                        _buildSection(
                          title: 'Typing Experience',
                          children: [
                            _buildDropdownSetting(
                              title: 'Keyboard Layout',
                              value: _selectedKeyboardLayout,
                              options: _keyboardLayouts,
                              onChanged: (value) {
                                setState(() {
                                  _selectedKeyboardLayout = value!;
                                });
                              },
                            ),
                            const Divider(color: Color(0xFF283339)),
                            _buildToggleSetting(
                              title: 'Sound Feedback',
                              description: 'Enable audio feedback on keypress.',
                              value: _soundFeedback,
                              onChanged: (value) {
                                setState(() {
                                  _soundFeedback = value;
                                });
                              },
                            ),
                            const Divider(color: Color(0xFF283339)),
                            _buildDropdownSetting(
                              title: 'Coding Language',
                              value: _selectedCodingLanguage,
                              options: _codingLanguages,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCodingLanguage = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Account Management Section
                        _buildSection(
                          title: 'Account Management',
                          children: [
                            _buildActionSetting(
                              title: 'Manage Profile',
                              description: 'Update your personal information.',
                              buttonText: 'Edit Profile',
                              onPressed: () {
                                // Handle edit profile
                              },
                            ),
                            const Divider(color: Color(0xFF283339)),
                            _buildActionSetting(
                              title: 'Change Password',
                              description: 'Set a new password for your account.',
                              buttonText: 'Change Password',
                              onPressed: () {
                                // Handle change password
                              },
                            ),
                            const Divider(color: Color(0xFF283339)),
                            _buildDangerActionSetting(
                              title: 'Delete Account',
                              description: 'Permanently delete your account and all data.',
                              buttonText: 'Delete Account',
                              onPressed: () {
                                _showDeleteAccountDialog();
                              },
                            ),
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
          onTap: () {
            // Handle navigation
          },
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

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTab == index;
    return Container(
      margin: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedTab = index;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: isSelected
                  ? const Color(0xFF1193D4)
                  : const Color(0xFF9DB0B9),
              padding: const EdgeInsets.only(bottom: 16),
            ),
            child: Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              color: const Color(0xFF1193D4),
            ),
        ],
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

  Widget _buildDropdownSetting({
    required String title,
    required String value,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
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
          SizedBox(
            width: 200,
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
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
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
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
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF9DB0B9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1193D4),
            activeTrackColor: const Color(0xFF1193D4).withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSetting({
    required String title,
    required String description,
    required String buttonText,
    required Function() onPressed,
  }) {
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
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF9DB0B9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF283339)),
              backgroundColor: const Color(0xFF1A2830),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerActionSetting({
    required String title,
    required String description,
    required String buttonText,
    required Function() onPressed,
  }) {
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
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFEF4444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF9DB0B9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
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
              buttonText,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    setState(() {
      _selectedKeyboardLayout = 'QWERTY';
      _soundFeedback = true;
      _selectedCodingLanguage = 'JavaScript';
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

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A2830),
          title: Text(
            'Delete Account',
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF9DB0B9),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF9DB0B9),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle account deletion
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Account deletion requested.',
                      style: GoogleFonts.spaceGrotesk(),
                    ),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
              ),
              child: Text(
                'Delete Account',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}