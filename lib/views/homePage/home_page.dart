import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:type_arena/views/authentication/login_page.dart';
import 'package:type_arena/views/widgets/auth_gate.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late AnimationController _typingController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _typingAnimation = CurvedAnimation(
      parent: _typingController,
      curve: Curves.easeInOut,
    );
    _typingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF282C34)),
                ),
              ),
              child: Row(
                children: [
                  // Logo and Title
                  Row(
                    children: [
                      const Icon(
                        Icons.keyboard,
                        color: Color(0xFF00BFFF),
                        size: 32,
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
                  // Navigation and Login
                  Row(
                    children: [
                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthGate()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFFF),
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
                          'Login',
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
            // Hero Section
            Container(
              padding: const EdgeInsets.all(64),
              child: Column(
                children: [
                  // Animated Code Snippet
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 512),
                    margin: const EdgeInsets.only(bottom: 32),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF282C34),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AnimatedBuilder(
                      animation: _typingAnimation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            // Base text
                            Text(
                              'function helloWorld() { console.log("Hello, Coder!"); }',
                              style: GoogleFonts.firaCode(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            // Animated typing overlay
                            ClipRect(
                              clipper: _TypingClipper(_typingAnimation.value),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'function ',
                                      style: GoogleFonts.firaCode(
                                        color: const Color(0xFFFFD700),
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'helloWorld',
                                      style: GoogleFonts.firaCode(
                                        color: const Color(0xFF00BFFF),
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '() { ',
                                      style: GoogleFonts.firaCode(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'console',
                                      style: GoogleFonts.firaCode(
                                        color: const Color(0xFFFF00FF),
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '.log(',
                                      style: GoogleFonts.firaCode(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '"Hello, Coder!"',
                                      style: GoogleFonts.firaCode(
                                        color: const Color(0xFF00FF7F),
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '); }',
                                      style: GoogleFonts.firaCode(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Cursor
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: AnimatedBuilder(
                                animation: _typingController,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _typingController.value * 2 % 1,
                                    child: Container(
                                      width: 2,
                                      color: const Color(0xFF00BFFF),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Main Title
                  Text(
                    'Master Your Keyboard. Code Faster.',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.033,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  SizedBox(
                    width: 512,
                    child: Text(
                      'Improve your typing speed and accuracy with real code snippets from your favorite languages and frameworks.',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFD4D4D4),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // CTA Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Start a Free Lesson',
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
            // Features Section
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  // Section Title
                  SizedBox(
                    width: 720,
                    child: Column(
                      children: [
                        Text(
                          'Unlock Your Coding Potential',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.033,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Our typing tutor is designed to help you become a more efficient and confident developer. Here\'s how:',
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFFD4D4D4),
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Features Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.code,
                        title: 'Real Code Snippets',
                        description: 'Practice with actual code from popular programming languages and frameworks.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.trending_up,
                        title: 'Track Your Progress',
                        description: 'Monitor your words-per-minute (WPM) and accuracy to see your skills improve over time.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.translate,
                        title: 'Multiple Languages',
                        description: 'Master typing in Python, JavaScript, React, and more. New languages are added regularly.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Languages Grid
            Container(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                children: [
                  _buildLanguageCard('Python', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDOD8M7pWQAznjcKnL3yduAZq00zwdHYb0nSZspF7SN1LHoOHsXwVvPI059jRDoTnYY1yjSs0YUoqx0WaYIIsWIGuL9D6r8-rSoYXeycIlAedPxWF9TJpo9tXkFc7-XNUs0DHei-4KGCGPKgGUHl7Ti2iTB2B-S4eCNvY59bNVCYgJYGxINOQab9ipeDbN5N8K4CDpLhK8xL7tWG2fv_yW78lDGDJUONB-z-un320Xc_DTjdQH0VnRj9T4haBGNajLeZDIlUJKcmi-m'),
                  _buildLanguageCard('JavaScript', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCanEyDKR2UaxBu-U9aXKHs5vikRtrqRTGoR5tq3lG3oQjcjsw1R3fv75D9Rm1JxBcx76tIYWjJ3_79mrVD-PKypuX0kAO9h90nC_GfjeP3gdSryaiTyERor8NKDEtVLZhJpNZZW1pitX6A-qpVWGLuAmeLSMRadTRF7wANKLrK-jGVz_dzDES6X-qQ2coyLkgxeUITD8W814GHjikU_PoilcN14qYyndnaUgFEGFvBt2_-_-TZMfgsHtqplzhTA9ZsDBcCcr99djUr'),
                  _buildLanguageCard('React', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDo52ypia91TOYGjbH8EMzYTKdfsAoj5kOUywCeVBxpjAlCYc25iWCbQnh7f2tlHLQ9Q1cUzFQ15Y2Xla_CDZORLSM73Q--opBj1VsadMPZn3INnxXODfjYQduzQd1i5IeTX8XslymAe3p2-frBlk9wIrmoTUwFNab2rjp89BS2uOoy1RDrQ-3Pie7nKTQ1mTMPZQUA4Fna5WHwT1YavEn1_tSjC4rsSPnPTOyhNe6pawVLijEilaD9TPb0tmv8nhsFLuys5g5gh2md'),
                  _buildLanguageCard('Vue', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDhdiXIVWknXwalQXaaBygRlCEwlL9iqf2yd7cy4pvcUO-dmL0fdnHYSZ4a_BYdmDmKMCbyTcn7kAFeFonbXmaoe8cQH1RYJNzx8s-jhLcWMRmBpIP-LGGLjDG5pJFJ2Zwevm9M7zEbCb6tsQD6kLg6N8W415ROXms4JKETUzKFqP73Jspup1bfeqY16cQpI-3_bAri0Mhh0sM_-uz2pWxsa7GjQLvsmXlLCbmrt7-onNbBvAOeRWd52xgq8aqyrr8CCbMUCI2mb-R_'),
                  _buildLanguageCard('Angular', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCZkfkoP4MGper0u_iUkOAqRaUWfFWZwg9GEcDK5fMKlZ03uqrljlqK8zAXFPtFqPjQ4j4KDXPkg7lqywMtf1OI3kj4ozi0jIYeEAuOaNmbv-Boo2lkocPHE__vu4Oc126S8EUOb1s10DobqP8duj4fr9ucBWjs-rzqYM9nFQMepMX4vNnMaFdRd-WPNtphjKX-KoYCELDHX94Yf5gqYprD87bP_eqPie7Bpdt9le-tZgMiFxs2ABXGbfAfSQ_5rc3exD1mkmTZWbWA'),
                  _buildLanguageCard('TypeScript', 'https://lh3.googleusercontent.com/aida-public/AB6AXuByR7BKlJkrffXHH1Mc4seggjnclUuWJqY-enXsLrMCfcLdXLKEoGkNv7kuyQL-vi7hPWPHV96GnBYnKV42a2INKmpniF91FmBlJVuxpV8eP9eqjdVS6OmVU5ls37cy2pui-a-0TP3JH67xcMi4qZkuZoUzgXA5RSUGG5KBsdQ0txvweO11uPeRYt1dF-9fAIkN1finerKx8ZfLSvP5yV2lKy4nbkc1TZYdnICIlnC4U4tDagaIOQE9vMPyet9BfbJbfT2wkNagr6je'),
                ],
              ),
            ),
            // Testimonials Section
            Container(
              padding: const EdgeInsets.all(64),
              child: Column(
                children: [
                  Text(
                    'What Our Users Say',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.033,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    childAspectRatio: 1.5,
                    children: [
                      _buildTestimonialCard(
                        name: 'Alex Johnson',
                        timeAgo: '2 days ago',
                        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAziiZUVzgB3VPcWUA6DdDHKKJqeDIgN12Qyghg-at4DyvXpUa1MkFhjbSjEXVZT8wM7cTmNBHiSPhTjFU_sPuCF6t4fMaxhXu554qX9AJ-ryU9RpGFT-oOGYpZ4r74FD6YXZ6hTHBaQ0M-jRfhgTVRpABWcrXbMbl4UUniTn4b6mycRHJw8VYjeMsxq7E8LFGvyKN5xrUzuJMdZPbHxiTLq3GbnIwb86uiDdZ9Zj0uU1Fjd9MWhTtJH3qJLzT0DCOWcnWijI_G9Uno',
                        rating: 5,
                        review: 'This is the best typing tutor for developers! I\'ve tried others, but none have helped me improve my speed and accuracy as much as this one. The real code snippets are a game-changer.',
                      ),
                      _buildTestimonialCard(
                        name: 'Samantha Lee',
                        timeAgo: '1 week ago',
                        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAqTINpq2yiSqv5sU4LxmcikzXAYvi9mXtDPaeChXx6OoDz8Khrbjc5Wer4KEX3U6wmLB7RgtoNsTPF5hdn_oEjsVbwTdHcJq_gY_DhkNWJPoUBOS0H8S9YmUsbuAKq0YgDvh9L5UHegUz0lVuyrLb5yfOGoZW38hejSvkeaNezKPCnyGxwYZhQiqLUj0a54BCfOQ6qt1Wee-0y6iSXSlOQDN_h6oMrjwugfZore0P-ubt2M5SDh9NsyQgDAGeY5_VrKjFMANlREPH-',
                        rating: 4.5,
                        review: 'I was skeptical at first, but after a week of using this typing tutor, I\'m a believer. My WPM has increased by 15, and I\'m making fewer mistakes when I code. Highly recommended!',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF282C34)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024 Typing Tutor. All rights reserved.',
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFD4D4D4),
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      _buildFooterLink('Terms of Service'),
                      _buildFooterLink('Privacy Policy'),
                      _buildFooterLink('Contact'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF282C34),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF282C34)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF00BFFF),
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFFD4D4D4),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(String name, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            name,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String timeAgo,
    required String avatarUrl,
    required double rating,
    required String review,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF282C34),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFD4D4D4),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Rating
          Row(
            children: List.generate(5, (index) {
              if (index < rating.floor()) {
                return const Icon(
                  Icons.star,
                  color: Color(0xFF00BFFF),
                  size: 20,
                );
              } else if (index == rating.floor() && rating % 1 != 0) {
                return const Icon(
                  Icons.star_half,
                  color: Color(0xFF00BFFF),
                  size: 20,
                );
              } else {
                return const Icon(
                  Icons.star_border,
                  color: Color(0xFF00BFFF),
                  size: 20,
                );
              }
            }),
          ),
          const SizedBox(height: 12),
          // Review
          Expanded(
            child: Text(
              review,
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFD4D4D4),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          color: const Color(0xFFD4D4D4),
          fontSize: 14,
        ),
      ),
    );
  }
}

class _TypingClipper extends CustomClipper<Rect> {
  final double progress;

  _TypingClipper(this.progress);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * progress, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}