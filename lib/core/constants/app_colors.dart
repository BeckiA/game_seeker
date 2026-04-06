import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF6366F1); // Indigo Vivid
  static const Color secondary = Color(0xFFF43F5E); // Rose
  
  // Background & Surface
  static const Color background = Color(0xFF0F172A); // Deep Slate
  static const Color surface = Color(0xFF1E293B); // Slate Blue
  static const Color surfaceLight = Color(0xFF334155);
  
  // Accents
  static const Color accentIndigo = Color(0xFF818CF8);
  static const Color accentRose = Color(0xFFFB7185);
  static const Color ratingGold = Color(0xFFFFD700);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  
  // States
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  
  // Gradients
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xCC0F172A), // Semi-transparent background
      Colors.transparent,
    ],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accentIndigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
