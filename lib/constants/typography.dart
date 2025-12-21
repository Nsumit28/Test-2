import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Vibely typography system
class VibelyTypography {
  // Headers - Sora Bold 20px
  static TextStyle header = GoogleFonts.sora(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textPrimary,
  );

  // Body - DM Sans Regular 16px
  static TextStyle body = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: VibelyColors.textPrimary,
  );

  // Labels - DM Sans Medium 12px
  static TextStyle label = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: VibelyColors.textPrimary,
  );

  // Buttons - DM Sans Bold 17px
  static TextStyle button = GoogleFonts.dmSans(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textPrimary,
  );

  // Custom styles used in wireframe
  static TextStyle stickerText = GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textPrimary,
  );

  static TextStyle nameText = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textPrimary,
  );

  static TextStyle distanceText = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: VibelyColors.textSecondary,
  );

  static TextStyle bioText = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: VibelyColors.textSecondary,
  );

  static TextStyle vibeBadgeText = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle sectionHeader = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: VibelyColors.secondary,
  );

  static TextStyle captionText = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle gridLabel = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle gridCaption = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textSecondary,
  );

  static TextStyle favoriteTitle = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: VibelyColors.textPrimary,
  );

  static TextStyle favoriteSubtitle = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: VibelyColors.textSecondary,
  );
}
