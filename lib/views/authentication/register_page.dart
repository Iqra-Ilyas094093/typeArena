import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:type_arena/utils/validators.dart';
import 'package:type_arena/view_model/auth_view_model.dart';
import 'package:type_arena/views/authentication/login_page.dart';
import 'package:type_arena/views/authentication/verification_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _showPasswordError = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFF111618),
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
                      // Header with Logo
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Text(
                          '<CodeTyper />',
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF1193D4),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Main Card
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C2327),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Title Section
                              Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: Column(
                                  children: [
                                    Text(
                                      'Create Your Account',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Start improving your typing skills today.',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFF9DB0B9),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Form Section
                              Column(
                                children: [
                                  // Username Field
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        validator:validateUsername,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        controller: usernameController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF1C2327),
                                          hintText: 'e.g., your_username',
                                          hintStyle: GoogleFonts.spaceGrotesk(
                                            color: const Color(0xFF9DB0B9),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF3B4B54),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF3B4B54),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF1193D4),
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.all(16),
                                        ),
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Email Field
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email Address',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        validator: validateEmail,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF1C2327),
                                          hintText: 'e.g., user@example.com',
                                          hintStyle: GoogleFonts.spaceGrotesk(
                                            color: const Color(0xFF9DB0B9),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF3B4B54),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF3B4B54),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF1193D4),
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.all(16),
                                        ),
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Password Field
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          TextFormField(
                                            validator: validatePassword,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            controller: passwordController,
                                            obscureText: _obscurePassword,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xFF1C2327),
                                              hintText: 'Enter your password',
                                              hintStyle: GoogleFonts.spaceGrotesk(
                                                color: const Color(0xFF9DB0B9),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF3B4B54),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF3B4B54),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF1193D4),
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.all(16),
                                            ),
                                            style: GoogleFonts.spaceGrotesk(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: const Color(0xFF9DB0B9),
                                            ),
                                            onPressed: _togglePasswordVisibility,
                                          ),
                                        ],
                                      ),
                                      if (_showPasswordError)
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Passwords do not match.',
                                            style: GoogleFonts.spaceGrotesk(
                                              color: const Color(0xFFF87171),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Confirm Password Field
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Confirm Password',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          TextFormField(
                                            validator: validatePassword,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            controller: confirmPasswordController,
                                            obscureText: _obscureConfirmPassword,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xFF1C2327),
                                              hintText: 'Confirm your password',
                                              hintStyle: GoogleFonts.spaceGrotesk(
                                                color: const Color(0xFF9DB0B9),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF3B4B54),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF3B4B54),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF1193D4),
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.all(16),
                                            ),
                                            style: GoogleFonts.spaceGrotesk(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              _obscureConfirmPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: const Color(0xFF9DB0B9),
                                            ),
                                            onPressed: _toggleConfirmPasswordVisibility,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Create Account Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: authVM.isLoading?null:ElevatedButton(
                                      onPressed: () async {
                                        if(passwordController.text == confirmPasswordController.text){
                                          if (_formKey.currentState!.validate()) {
                                            final ok = await authVM.register(
                                              email: emailController.text.trim(),
                                              password: passwordController.text,
                                              username: usernameController.text.trim(),
                                            );
                                            if (ok) {
                                              await authVM.sendOtp(emailController.text);
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VerificationScreen(email: emailController.text.toString(),)));
                                            } else {
                                              print(authVM.error);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(authVM.error ?? 'Error')),
                                              );
                                            }
                                          }
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('passwords dont match')));
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF1193D4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Create My Account',
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Divider with "Or continue with"
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: const Color(0xFF3B4B54),
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'Or continue with',
                                          style: GoogleFonts.spaceGrotesk(
                                            color: const Color(0xFF9DB0B9),
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
                                  const SizedBox(height: 24),

                                  // Social Login Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 48,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              // Handle GitHub login
                                            },
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: const Color(0xFF1C2327),
                                              side: const BorderSide(
                                                color: Color(0xFF3B4B54),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // GitHub SVG icon as text representation
                                                const Icon(
                                                  Icons.code,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'GitHub',
                                                  style: GoogleFonts.spaceGrotesk(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SizedBox(
                                          height: 48,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              // Handle Google login
                                            },
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: const Color(0xFF1C2327),
                                              side: const BorderSide(
                                                color: Color(0xFF3B4B54),
                                              ),
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
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Google',
                                                  style: GoogleFonts.spaceGrotesk(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Terms and Privacy
                                  Container(
                                    margin: const EdgeInsets.only(top: 32),
                                    child: Text(
                                      'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFF9DB0B9),
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  // Login Link
                                  Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account?',
                                          style: GoogleFonts.spaceGrotesk(
                                            color: const Color(0xFF9DB0B9),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                                          },
                                          child: Text(
                                            'Log in',
                                            style: GoogleFonts.spaceGrotesk(
                                              color: const Color(0xFF1193D4),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}