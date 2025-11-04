import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:type_arena/view_model/auth_view_model.dart';
import 'package:type_arena/views/dashboard/dashboard_page.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _minutes = 0;
  int _seconds = 59;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _setupOtpInputListeners();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            timer.cancel();
          }
        }
      });
    });
  }

  void _setupOtpInputListeners() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < _controllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }

        // Auto-verify when all fields are filled
        if (_isAllFieldsFilled()) {
          _verifyCode();
        }
      });
    }
  }

  bool _isAllFieldsFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  void _verifyCode() {
    // Combine all OTP digits
    String code = _controllers.map((controller) => controller.text).join();
    print('Verifying code: $code');
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashboardPage()));
    // Here you would typically verify the code with your backend
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verifying code: $code'),
        backgroundColor: const Color(0xFF1193D4),
      ),
    );
  }

  void _resendCode() {
    setState(() {
      _minutes = 0;
      _seconds = 59;
    });
    _startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code sent!'),
        backgroundColor: Color(0xFF1193D4),
      ),
    );
  }
  String getOtp(){
    return _controllers.map((e)=>e.text).join('');
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFF101C22),
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
                      // Header Section
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          children: [
                            Text(
                              'Verify Your Email',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                                letterSpacing: -0.033,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'A verification code has been sent to your email. Please enter it below.',
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

                      // OTP Input Fields
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 48,
                              height: 64,
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B4B54),
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B4B54),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF1193D4),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.length == 1 && index < 5) {
                                    _focusNodes[index + 1].requestFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),

                      // Verify Button
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 200),
                        height: 48,
                        child: ElevatedButton(
                          onPressed: authVM.isLoading
                              ? null
                              : () async {
                            final otp = getOtp();
                            final isVerified =
                            await authVM.verifyOtp(widget.email,otp);

                            if (isVerified && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DashboardPage(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1193D4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: authVM.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                            'Verify',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.015,
                            ),
                          ),
                        ),
                      ),

                      // Timer Section
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Minutes
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF283339),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _minutes.toString().padLeft(2, '0'),
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Minutes',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Seconds
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF283339),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _seconds.toString().padLeft(2, '0'),
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Seconds',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white,
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

                      // Resend Code
                      Text.rich(
                        TextSpan(
                          text: "Didn't receive the code? ",
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF9DB0B9),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: _resendCode,
                                child: Text(
                                  'Resend',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: const Color(0xFF1193D4),
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
}