import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111618),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    children: [
                      // Header Section
                      const Column(
                        children: [
                          Icon(
                            Icons.keyboard,
                            color: Color(0xFF1193D4),
                            size: 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Level Up Your Coding Speed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              letterSpacing: -0.033,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Login to Start Typing',
                            style: TextStyle(
                              color: Color(0xFF9DB0B9),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Login Form
                      Column(
                        children: [
                          // Username/Email Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username or Email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFF283339),
                                  hintText: 'Enter your username or email',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF9DB0B9),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFF283339),
                                  hintText: 'Enter your password',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF9DB0B9),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF9DB0B9),
                                    ),
                                    onPressed: _togglePasswordVisibility,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Remember Me & Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return const Color(0xFF1193D4);
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                    checkColor: Colors.white,
                                    side: const BorderSide(
                                      color: Color(0xFF3B4B54),
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle forgot password
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color(0xFF1193D4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle login
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1193D4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.015,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // OR Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: const Color(0xFF3B4B54),
                                  thickness: 1,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Color(0xFF9DB0B9),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: const Color(0xFF3B4B54),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Google Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle Google sign in
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA-pkTBeITdfEhYUojc1qTaIKW7XxqVzOovV8g36kcGFqEO6IQKhcX5X8IJeUfKgUo3-bsb0C4jrW_ErS2fgY3BllMalGmXnMWX3hZF3bMgCEhZIijDJSDjvzfnbLIV8REuZ7J_f6qSusLyxypy1xMb5AtKXG4batnAfciPDIj6xFu8ngg8SqS2dzezDLdFwh6OYvUUdhSwwTWQSwlWaHUklbW0pfGAv5x4ezokV7xf2GC97yjqa-08D13R0x8HNzF5s64GkGu2Vl2z',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Sign Up Link
                      const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF9DB0B9),
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF1193D4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
}