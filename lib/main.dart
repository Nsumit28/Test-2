import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/profile_card_page.dart';
import 'data/sample_data.dart';

void main() {
  runApp(const VibelyApp());
}

/// Main Vibely Profile Cards App
class VibelyApp extends StatelessWidget {
  const VibelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibely Profile Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: VibelyColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: VibelyColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: VibelyColors.textPrimary,
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// Home page showing the profile card
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Using sample profile data
    final profile = SampleData.sampleProfile;

    return ProfileCardPage(profile: profile);
  }
}
