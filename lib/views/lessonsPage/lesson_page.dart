import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategory = 0; // 0: All, 1: Beginner, 2: Intermediate, 3: Advanced

  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'JavaScript Functions',
      'description': 'Practice typing common JavaScript function declarations and invocations.',
      'language': 'JavaScript',
      'level': 'Intermediate',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCtTgB1hoa3EOEfmkBlLi_R2lNfQBBqm-ywHW0qpfTJVH8oIkjQ6MPiKs6OvK-EjL5DdfaO5Rczisgyj9snxvvutE5OpUTtnU-jZfJQwD1_3PJx8w77mFyOobUkwd4vgBIpEgVi_ovksbc5-92DZQOiMzO02K-Xp3B5mOEGz8S05O1XdzrGiAmAfQk8O7xDMGtrHN_YvUKrykSr6bRJeo-eeXjVluhsmqqX31CvCWHJG7XtOu0h1EFuobHb0pO8ytAFsa8awpYONDcf',
      'buttonText': 'Start Lesson',
    },
    {
      'title': 'Python Loops',
      'description': 'Master \'for\' and \'while\' loops in Python with this lesson.',
      'language': 'Python',
      'level': 'Beginner',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDxdNDpJyjlvTIA3X0PxjQGZCFxEIMKhI5-zHN3Ba-WE8z7UgL1cK9ZQEZiHKxvzAm_tjraEKtVLP0zqFAAthXJ8fCq8C6La-mZme1J5mM3_UiA8HuDimam0BWy5ny_CjoL4QgPMs7ymGReyDCCzLvcJ0lkt5b2-ZDdn1a1ePzb5-Ob7JormwzZe3FeJfscpRNyUhPWyNhRov0hG8rlQymXOhtjoZZmh0yiiPM3BWU1aZm1dXry2pwHZ3gn-S5dcTmGXYRC3nndwiwo',
      'buttonText': 'Practice Now',
    },
    {
      'title': 'C++ Pointers',
      'description': 'Get comfortable with pointers and memory management in C++.',
      'language': 'C++',
      'level': 'Advanced',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAct1I4IlOwr6-ivU9ox2BLaDQovemwtChwPoYq9ENjfRCE1w-ycrqlLMeGZG31VqGJGdOlxouFc21lLLyxIlwpHGUNLSrNfCP1_Z3gJj-qh13zms0McNHaB3-nW4fqIOglbUbeuhOqGhFPYg2hY0ax4W-vUw-D94ltaE4v0m2gSO0xLC0Z6y7OjGAe4H02CmmslthpjyLydepB9LVvpwwGBvbQml5UtDIegGChIiWOC7R8ZCwCCeUdyiKKeGDSWN1rPhN8cYq5xkRi',
      'buttonText': 'Start Lesson',
    },
  ];

  final List<String> _categories = [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111618),
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
                // Logo and Navigation
                Expanded(
                  child: Row(
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
                          color: Color(0xFF111618),
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
                      const SizedBox(width: 32),
                      // Navigation Links (hidden on mobile)
                      if (MediaQuery.of(context).size.width > 768)
                        Row(
                          children: [
                            _buildNavLink('Home'),
                            _buildNavLink('Profile'),
                            _buildNavLink('Leaderboards'),
                          ],
                        ),
                    ],
                  ),
                ),
                // Search and Auth Buttons
                Row(
                  children: [
                    // Search Bar (hidden on mobile)
                    if (MediaQuery.of(context).size.width > 640)
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFF9DB0B9),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFF9DB0B9),
                              size: 20,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF283339),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    // Auth Buttons
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle sign up
                          },
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
                          child: Text(
                            'Sign Up',
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
                            // Handle log in
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
                            'Log In',
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
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Page Title
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        Text(
                          'Typing Lessons',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.033,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Category Filters
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_categories.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: FilterChip(
                              label: Text(
                                _categories[index],
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: _selectedCategory == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedCategory = selected ? index : 0;
                                });
                              },
                              backgroundColor: const Color(0xFF283339),
                              selectedColor: const Color(0xFF1193D4),
                              labelStyle: TextStyle(
                                color: _selectedCategory == index
                                    ? Colors.white
                                    : Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  // Lessons List
                  Column(
                    children: _lessons.map((lesson) {
                      return _buildLessonCard(
                        title: lesson['title'] as String,
                        description: lesson['description'] as String,
                        language: lesson['language'] as String,
                        level: lesson['level'] as String,
                        imageUrl: lesson['imageUrl'] as String,
                        buttonText: lesson['buttonText'] as String,
                      );
                    }).toList(),
                  ),
                  // Pagination
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle previous page
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
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: Text(
                            'Previous',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle next page
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
                          label: Text(
                            'Next',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          icon: const Icon(Icons.arrow_forward, size: 16),
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

  Widget _buildLessonCard({
    required String title,
    required String description,
    required String language,
    required String level,
    required String imageUrl,
    required String buttonText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: const Color(0xFF1C2327),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        child: InkWell(
          onTap: () {
            // Handle lesson selection
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Lesson Content
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      Row(
                        children: [
                          _buildTag(language),
                          const SizedBox(width: 8),
                          _buildTag(level),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        description,
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF9DB0B9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Action Button
                      ElevatedButton(
                        onPressed: () {
                          // Start lesson
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1193D4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          buttonText,
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
                // Lesson Image (hidden on mobile)
                if (MediaQuery.of(context).size.width > 640)
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF283339),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          color: const Color(0xFF9DB0B9),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}