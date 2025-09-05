// lib/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/guide_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF13EC5B);
    const secondaryColor = Color(0xFF0D1B12);
    const backgroundColor = Color(0xFFF8FCF9);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                        letterSpacing: -2,
                      ),
                      children: const [
                        TextSpan(text: 'GiveA'),
                        TextSpan(
                          text: 'Byte',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text(
                    'Reduce E-Waste,\nShare the Tech',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join a community dedicated to reducing electronic waste by donating and receiving devices.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GuideScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: secondaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 5,
                  shadowColor: primaryColor.withOpacity(0.4),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}