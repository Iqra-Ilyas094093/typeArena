import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:type_arena/views/lessonsPage/lesson_page.dart';
import 'package:type_arena/views/settings_customization/appearance.dart';
import 'package:type_arena/views/typing_screen/typing_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTimeFilter = 1; // 0: 7 days, 1: 30 days, 2: All time

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
                // Navigation Links (hidden on mobile)
                if (MediaQuery.of(context).size.width > 768)
                  Row(
                    children: [
                      _buildNavLink('Dashboard',(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashboardPage()));
                      }, isActive: true),
                      _buildNavLink('Practice',(){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TypingPracticePage()));  }),
                      _buildNavLink('Lessons',(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LessonsPage()));}),
                      _buildNavLink('Settings',(){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage())); }),
                    ],
                  ),
                const SizedBox(width: 32),
                // User Profile
                if (MediaQuery.of(context).size.width > 768)
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA5ITI8M1KCjyvzERo2_eE2AKd3dujYRb2nuFmLy4SL0IDFtcC2YZA8NHE477wzsXnCgye2yiCdhS2qEkmYSFUAYDsi5PDWZvfhGAngf_gwMsrFqyeDNZMIWnMDDfWFy3CVIBNZGBYVWTX_DoFYYJXjpHcYONs0bMHonYTn0dAVIE5b54VOE8jzCzdOLEs0xk1gwoy1UdvjZJYKMmLEfjAH9H-xPwSOtBHep-s1lWe-OosPU-2cVeJWaGBdxHm8OPRLW0vBe36rsd2R',
                    ),
                  ),
                // Mobile menu button
                if (MediaQuery.of(context).size.width <= 768)
                  IconButton(
                    onPressed: () {
                      // Handle mobile menu
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
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
                  // Welcome Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        Text(
                          'Welcome back, Alex!',
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
                  // Stats Grid
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    children: [
                      _buildStatCard('WPM', '75', '+5%', true),
                      _buildStatCard('Accuracy', '98%', '-1%', false),
                      _buildStatCard('Lessons Completed', '25', '+10%', true),
                      _buildStatCard('Longest Streak', '14 days', '+2 days', true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Progress Chart and Next Steps
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Chart
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A2A33),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF3B4B54)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Progress',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'WPM',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Time Filter Buttons
                                  Row(
                                    children: [
                                      _buildTimeFilterButton('7 days', 0),
                                      _buildTimeFilterButton('30 days', 1),
                                      _buildTimeFilterButton('All time', 2),
                                    ],
                                  ),
                                ],
                              ),
                              // Subtitle
                              Row(
                                children: [
                                  Text(
                                    'Last 30 days',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: const Color(0xFF9DB0B9),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '+5%',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: const Color(0xFF0BDA57),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Chart Placeholder
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x4D1193D4),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: CustomPaint(
                                  painter: _ChartPainter(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Week Labels
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildWeekLabel('Week 1'),
                                  _buildWeekLabel('Week 2'),
                                  _buildWeekLabel('Week 3'),
                                  _buildWeekLabel('Week 4'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Next Steps
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A2A33),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF3B4B54)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Next Steps',
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.015,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "You're doing great! Keep up the momentum by tackling the next lesson.",
                                style: GoogleFonts.spaceGrotesk(
                                  color: const Color(0xFF9DB0B9),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1193D4),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Start Next Lesson: Python Functions',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFF1193D4)),
                                  backgroundColor: const Color(0x331193D4),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Practice Your Weakest Keys',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Recent Activity and Achievements
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recent Activity
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 12, top: 20),
                              child: Text(
                                'Recent Activity',
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.015,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                _buildActivityItem('JavaScript Loops', 82, 99),
                                _buildActivityItem('Python Variables', 78, 97),
                                _buildActivityItem('CSS Selectors', 72, 98),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Achievements
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 12, top: 20),
                              child: Text(
                                'Achievements',
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.015,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A2A33),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF3B4B54)),
                              ),
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                children: [
                                  _buildAchievement(Icons.speed, 'Speed Demon', true),
                                  _buildAchievement(Icons.verified, 'Accuracy Ace', true),
                                  _buildAchievement(Icons.local_fire_department, 'Streak Master', true),
                                  _buildAchievement(Icons.school, 'Lesson Guru', false),
                                  _buildAchievement(Icons.code, 'Python Pro', false),
                                  _buildAchievement(Icons.keyboard, 'Keyboard Warrior', false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text,VoidCallback ontap, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: ontap,
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

  Widget _buildStatCard(String title, String value, String change, bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A33),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF3B4B54)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? const Color(0xFF0BDA57) : const Color(0xFFFA5F38),
                size: 18,
              ),
              Text(
                change,
                style: GoogleFonts.spaceGrotesk(
                  color: isPositive ? const Color(0xFF0BDA57) : const Color(0xFFFA5F38),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilterButton(String text, int index) {
    final isSelected = _selectedTimeFilter == index;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTimeFilter = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF1193D4) : const Color(0x331193D4),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildWeekLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        color: const Color(0xFF9DB0B9),
        fontSize: 13,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.015,
      ),
    );
  }

  Widget _buildActivityItem(String title, int wpm, int accuracy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A33),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF3B4B54)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'WPM: ',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFF9DB0B9),
                      ),
                    ),
                    TextSpan(
                      text: '$wpm',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Accuracy: ',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFF9DB0B9),
                      ),
                    ),
                    TextSpan(
                      text: '$accuracy%',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
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

  Widget _buildAchievement(IconData icon, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: unlocked ? const Color(0x331193D4) : const Color(0x333B4B54),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: unlocked ? const Color(0xFF1193D4) : const Color(0xFF9DB0B9),
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: unlocked ? Colors.white : const Color(0xFF9DB0B9),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1193D4)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x4D1193D4),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    // Simplified chart path (you can make this more sophisticated)
    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width * 0.1, size.height * 0.2)
      ..lineTo(size.width * 0.2, size.height * 0.3)
      ..lineTo(size.width * 0.3, size.height * 0.1)
      ..lineTo(size.width * 0.4, size.height * 0.6)
      ..lineTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(size.width * 0.6, size.height * 0.8)
      ..lineTo(size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.9)
      ..lineTo(size.width * 0.9, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.7);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}