// lib/login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/main_screen.dart';
import 'package:flutter_application_donation/login_screen.dart';
import 'package:flutter_application_donation/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF16A34A);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 24),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.green,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Join GiveAByte',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0D141B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'To get started, we need your permission for notifications and location access. This helps us connect you with nearby donations.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(color: Colors.green.shade200, width: 2),
                    ),
                    child: Text(
                      'Log In',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                  children: [
                    const TextSpan(text: 'By continuing, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Handle Terms of Service tap
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Handle Privacy Policy tap
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  children: [
                    const TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      text: 'SIGN UP',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
