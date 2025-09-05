// lib/guide_screen.dart
import 'package:flutter/material.dart';

import 'package:flutter_application_donation/onboard_screen.dart';
import 'package:flutter_application_donation/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF16A34A);
    const secondaryColor = Color(0xFF15803D);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFFF9FAFB),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_circle_outline, color: primaryColor, size: 32),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: Text(
                'Your guide to giving and receiving electronics.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Giving a Device?', primaryColor),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.upload_file,
                    title: '1. Upload It',
                    description: 'Easily list your unused electronics with a few taps.',
                    primaryColor: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.description,
                    title: '2. Add Details',
                    description: 'Provide a quick description to help others understand its value.',
                    primaryColor: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.check_circle,
                    title: '3. Make it Live',
                    description: 'Publish your listing and make it available to the community.',
                    primaryColor: primaryColor,
                  ),
                  const SizedBox(height: 48),
                  _buildSectionTitle('Need a Device?', primaryColor),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.search,
                    title: '1. Find It',
                    description: 'Search or browse for the specific electronic device you need.',
                    primaryColor: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.thumb_up,
                    title: '2. Claim It',
                    description: 'Once you find a match, send a request to claim the item.',
                    primaryColor: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  _buildStep(
                    icon: Icons.people,
                    title: '3. Connect & Collect',
                    description: 'Chat with the donor to arrange a pickup time and location.',
                    primaryColor: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnboardScreen()),
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
            shadowColor: primaryColor.withOpacity(0.4),
          ),
          child: Text(
            'Let\'s Get Started',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildStep({required IconData icon, required String title, required String description, required Color primaryColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: primaryColor, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
