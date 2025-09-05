// lib/device_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/models/device.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceDetails extends StatelessWidget {
  final Device device;

  const DeviceDetails({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name, style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(device.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              device.name,
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              device.category,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            const SizedBox(height: 8),
            Text(
              device.description,
              style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[800]),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Specifications'),
            const SizedBox(height: 16),
            _buildSpecifications(),
            const SizedBox(height: 24),
            _buildSectionTitle('Uploader\'s Notes'),
            const SizedBox(height: 8),
            Text(
              device.uploaderNotes,
              style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[800]),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message sent!')),
                );
              },
              child: Text(
                'Message Uploader',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSpecifications() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSpecRow('Brand', device.brand),
            _buildSpecRow('Year', device.year),
            _buildSpecRow('Processor', device.processor),
            _buildSpecRow('RAM', device.ram),
            _buildSpecRow('Storage', device.storage),
            _buildSpecRow('Condition', device.condition, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String title, String value, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        if (!isLast) const Divider(height: 24),
      ],
    );
  }
}