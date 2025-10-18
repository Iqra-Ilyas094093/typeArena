import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _deleteConfirmationController = TextEditingController();

  int _selectedSection = 0; // 0: Profile, 1: Security, 2: Account

  @override
  void initState() {
    super.initState();
    _usernameController.text = 'AlexCode';
    _emailController.text = 'alex.code@example.com';
    _currentPasswordController.text = '************';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _deleteConfirmationController.dispose();
    super.dispose();
  }

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
              color: Color(0xFF1A262C),
            ),
            child: Column(
              children: [
                // User Info Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBbYf1ftfkfe2PS_E68hcbFwwcljJZ-iilV5R8HjTrKR2D6__ahwTJUgo_N874JTCzAn5TUuIX-Tv3Yln39Zm-xFF_7iNSjDzXVq21zGOMYMhQxS5-kQcJrial_acEmBt0ZfmTh39TvXLbP-p72OUcfpef3Qxi0eaEgaFUJMrqYTqLTDy-yxj8uxLzDg46Ymi_2zTtOPSAeiVMp7X9pxKl0neDRb_p1DrJPnD7Xz5DpqpD9gmvvnySk2TGKZniYW2zQ2kDZjgIIZhwi',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AlexCode',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'alex.code@example.com',
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
                ),
                // Navigation Menu
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildNavItem(
                          icon: Icons.person,
                          title: 'Profile',
                          isActive: _selectedSection == 0,
                          onTap: () => setState(() => _selectedSection = 0),
                        ),
                        _buildNavItem(
                          icon: Icons.lock,
                          title: 'Security',
                          isActive: _selectedSection == 1,
                          onTap: () => setState(() => _selectedSection = 1),
                        ),
                        _buildNavItem(
                          icon: Icons.settings,
                          title: 'Account',
                          isActive: _selectedSection == 2,
                          onTap: () => setState(() => _selectedSection = 2),
                        ),
                      ],
                    ),
                  ),
                ),
                // Logout Button
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Container(
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
                    if (_selectedSection == 0) _buildProfileSection(),
                    if (_selectedSection == 1) _buildSecuritySection(),
                    if (_selectedSection == 2) _buildAccountSection(),
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
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0x334A90E2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? const Color(0xFF4A90E2) : const Color(0xFF9DB0B9),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: isActive ? const Color(0xFF4A90E2) : const Color(0xFF9DB0B9),
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

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.033,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your public information.',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF9DB0B9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        // Form
        SizedBox(
          width: 512,
          child: Column(
            children: [
              _buildFormField(
                label: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 24),
              _buildFormField(
                label: 'Email',
                controller: _emailController,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveProfileChanges();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
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
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.015,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      _cancelProfileChanges();
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
                      'Cancel',
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
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.033,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Change your password and manage security options.',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF9DB0B9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        // Security Content
        SizedBox(
          width: 512,
          child: Column(
            children: [
              // Change Password Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0x0DFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF283339)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change Password',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      label: 'Current Password',
                      controller: _currentPasswordController,
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      label: 'New Password',
                      controller: _newPasswordController,
                      hintText: 'Enter new password',
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      label: 'Confirm New Password',
                      controller: _confirmPasswordController,
                      hintText: 'Confirm new password',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _changePassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
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
                        'Change Password',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Two-Factor Authentication Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0x0DFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF283339)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Two-Factor Authentication',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add an extra layer of security to your account.',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFF9DB0B9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Status: '),
                              TextSpan(
                                text: 'Enabled',
                                style: GoogleFonts.spaceGrotesk(
                                  color: const Color(0xFF0BDA57),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            _manageTwoFactorAuth();
                          },
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
                            'Manage',
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.033,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Handle account-level actions.',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF9DB0B9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        // Account Content
        SizedBox(
          width: 512,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0x1AEF4444),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x33EF4444)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete Account',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFEF4444),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Warning: This action is permanent and cannot be undone. Deleting your account will remove all your data, including typing history and progress.',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFEF4444),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _buildDeleteConfirmationField(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _deleteAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD0021B),
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
                        'Delete My Account',
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
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1A2830),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF283339)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF283339)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A90E2)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: true,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF9DB0B9),
            ),
            filled: true,
            fillColor: const Color(0xFF1A2830),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF283339)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF283339)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A90E2)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteConfirmationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To confirm, type "DELETE" below:',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFFEF4444),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _deleteConfirmationController,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: 'DELETE',
            hintStyle: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF9DB0B9),
            ),
            filled: true,
            fillColor: const Color(0xFF1A2830),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _saveProfileChanges() {
    // Save profile changes
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Profile updated successfully!',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }

  void _cancelProfileChanges() {
    // Reset to original values
    _usernameController.text = 'AlexCode';
    _emailController.text = 'alex.code@example.com';
  }

  void _changePassword() {
    // Change password logic
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New passwords do not match!',
            style: GoogleFonts.spaceGrotesk(),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Password changed successfully!',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }

  void _manageTwoFactorAuth() {
    // Navigate to 2FA management
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening Two-Factor Authentication settings...',
          style: GoogleFonts.spaceGrotesk(),
        ),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }

  void _deleteAccount() {
    if (_deleteConfirmationController.text != 'DELETE') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please type "DELETE" to confirm account deletion.',
            style: GoogleFonts.spaceGrotesk(),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A2830),
          title: Text(
            'Delete Account',
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFFEF4444),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you absolutely sure? This action cannot be undone. All your data will be permanently deleted.',
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
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Account deletion scheduled.',
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