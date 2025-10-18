import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isSubmitted = false;

  void _sendResetLink() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _isSubmitted = true;
      });
      // Here you would typically call your API to send the reset link
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      // Keyboard Icon
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: const Icon(
                          Icons.keyboard,
                          color: Color(0xFF007BFF),
                          size: 48,
                        ),
                      ),

                      // Title Section
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: [
                            Text(
                              'Forgot Password',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Enter your email address and we'll send you a link to reset your password.",
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF9DB0B9),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Email Input Field
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email Address',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFFE0E0E0),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF2D2D2D),
                                hintText: 'youremail@example.com',
                                hintStyle: GoogleFonts.spaceGrotesk(
                                  color: const Color(0xFF9DB0B9),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF007BFF),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFFE0E0E0),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),

                      // Send Reset Link Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _sendResetLink,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007BFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Send Reset Link',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.015,
                            ),
                          ),
                        ),
                      ),

                      // Success Message (shown after submission)
                      if (_isSubmitted)
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Text(
                            'If an account with this email exists, a password reset link has been sent.',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFFE0E0E0),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Back to Login Link
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Go back to login page
                          },
                          child: Text(
                            'Back to Login',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFF9DB0B9),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}