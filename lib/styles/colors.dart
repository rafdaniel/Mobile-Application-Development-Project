// lib/styles/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // 🔷 Primary Teal Palette
  static const Color primary = Color(0xFF00796B);   
  static const Color primaryLight = Color(0xFF4DB6AC); 
  static const Color primaryDark = Color(0xFF004C40);  

  // 🟩 Secondary Green (for success, eco, donate cues)
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryLight = Color(0xFF81C784);
  static const Color secondaryDark = Color(0xFF2E7D32);

  // ⚪ Background & Surfaces
  static const Color background = Color(0xFFF8FAFB); 
  static const Color surface = Color(0xFFFFFFFF);    

  // ⚫ Text & Icons
  static const Color textPrimary = Color(0xFF101010); 
  static const Color textSecondary = Color(0xFF616161); 
  static const Color textHint = Color(0xFF9E9E9E);  

  // 🔴 Error & Alerts
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF9A9A);

  // 🔵 Info & Other
  static const Color info = Color(0xFF0288D1);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFFA000);

  // 💠 Gradients (ready to use)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [secondaryLight, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}