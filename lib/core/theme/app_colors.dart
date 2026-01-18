import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1E293B); // Blue Slate (gelap tapi masih terang & modern)
  static const Color primaryDark = Color(0xFF020617);
  static const Color primaryLight = Color(0xFF334155);

  // Secondary / Accent Colors
  static const Color secondary = Color(0xFF10B981); // Emerald (CTA, success, highlight)
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondaryLight = Color(0xFF34D399);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF1F5F9); // Soft Gray (terang, tidak menyilaukan)
  static const Color backgroundDark = Color(0xFF0F172A); // Dark Blue Gray
  static const Color surfaceLight = Color(0xFFFFFFFF); // White (Card)
  static const Color surfaceDark = Color(0xFF1E293B); // Dark surface
  static const Color darkCardBase = Color(0xFF020617); // Dark Card base (use with opacity)

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Primary text
  static const Color textSecondary = Color(0xFF475569); // Secondary text
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnDark = Color(0xFFE5E7EB); // Text on dark background (readable & profesional)
  static const Color textLight = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF22C55E); // Success
  static const Color error = Color(0xFFEF4444); // Error
  static const Color warning = Color(0xFFF59E0B); // Warning
  static const Color info = Color(0xFF3B82F6);

  // Border Colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  // Dark Card with opacity helpers
  // ignore: deprecated_member_use
  static Color darkCard([double opacity = 0.9]) => darkCardBase.withOpacity(opacity);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
