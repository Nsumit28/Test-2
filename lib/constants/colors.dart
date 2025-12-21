import 'package:flutter/material.dart';

/// Vibely color palette from Notion design system
class VibelyColors {
  // Primary colors
  static const Color primary = Color(0xFFFF5459); // Coral Burst
  static const Color secondary = Color(0xFFE68161); // Sunset Orange

  // Background colors
  static const Color background = Color(0xFFFCFCF9); // Cream Cloud
  static const Color cardBackground = Color(0xFFFFF5F0); // Soft Peach

  // Text colors
  static const Color textPrimary = Color(0xFF1F2121); // Deep Espresso
  static const Color textSecondary = Color(0xFF626C71); // Slate Medium

  // UI colors
  static const Color white = Colors.white;
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color progressInactive = Color(0x66626C71); // 40% opacity

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient imageOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xB3000000)], // 70% black
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
