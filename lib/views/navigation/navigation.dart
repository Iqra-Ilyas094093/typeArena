import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard/dashboard_page.dart';
import '../lessonsPage/lesson_page.dart';
import '../settings_customization/appearance.dart';
import '../typing_screen/typing_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardPage(),
    Scaffold(),
    // TypingPracticePage(),
    LessonsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
      body: Column(
        children: [
          // Top Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF283339)),
              ),
            ),
            child: Row(
              children: [
                // Logo + Title
                Row(
                  children: [
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

                // Desktop Navigation Links
                if (MediaQuery.of(context).size.width > 768)
                  Row(
                    children: [
                      _buildNavLink('Dashboard', 0),
                      _buildNavLink('Practice', 1),
                      _buildNavLink('Lessons', 2),
                      _buildNavLink('Settings', 3),
                    ],
                  ),

                const SizedBox(width: 32),

                // Profile
                if (MediaQuery.of(context).size.width > 768)
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA5ITI8M1KCjyvzERo2_eE2AKd3dujYRb2nuFmLy4SL0IDFtcC2YZA8NHE477wzsXnCgye2yiCdhS2qEkmYSFUAYDsi5PDWZvfhGAngf_gwMsrFqyeDNZMIWnMDDfWFy3CVIBNZGBYVWTX_DoFYYJXjpHcYONs0bMHonYTn0dAVIE5b54VOE8jzCzdOLEs0xk1gwoy1UdvjZJYKMmLEfjAH9H-xPwSOtBHep-s1lWe-OosPU-2cVeJWaGBdxHm8OPRLW0vBe36rsd2R',
                    ),
                  ),

                // Mobile Menu Button
                if (MediaQuery.of(context).size.width <= 768)
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
              ],
            ),
          ),

          // Page Content
          Expanded(
            child: screens[selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, int index) {
    bool isActive = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (selectedIndex != index) {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        child: Text(
          text,
          style: GoogleFonts.spaceGrotesk(
            color: isActive ? const Color(0xFF1193D4) : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
