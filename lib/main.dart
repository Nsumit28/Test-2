import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/profile_card_page.dart';
import 'data/sample_data.dart';
import 'models/profile_model.dart';

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

/// Home page managing profile navigation with animations
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ProfileModel> _profiles = SampleData.sampleProfiles;
  int _currentProfileIndex = 0;
  final List<int> _skippedProfiles =
      []; // Stack of skipped profile indices for undo

  ProfileModel get currentProfile => _profiles[_currentProfileIndex];
  bool get canUndo => _skippedProfiles.isNotEmpty;
  bool get hasMoreProfiles => _currentProfileIndex < _profiles.length - 1;

  void _onVibeSignal() {
    debugPrint('💫 Vibe Signal sent to ${currentProfile.name}!');
    _goToNextProfile(isLike: true);
  }

  void _onSkip() {
    debugPrint('✕ Skipped ${currentProfile.name}');
    _skippedProfiles.add(_currentProfileIndex);
    _goToNextProfile(isLike: false);
  }

  void _onUndo() {
    if (canUndo) {
      final previousIndex = _skippedProfiles.removeLast();
      debugPrint('↶ Undo - Going back to ${_profiles[previousIndex].name}');
      setState(() {
        _currentProfileIndex = previousIndex;
      });
    } else {
      debugPrint('↶ Undo - No profiles to go back to');
    }
  }

  void _goToNextProfile({required bool isLike}) {
    if (hasMoreProfiles) {
      setState(() {
        _currentProfileIndex++;
      });
    } else {
      debugPrint('No more profiles available!');
      // Could show end-of-stack UI here
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCardPage(
      key: ValueKey(currentProfile.id), // Force rebuild on profile change
      profile: currentProfile,
      onVibeSignal: _onVibeSignal,
      onSkip: _onSkip,
      onUndo: _onUndo,
      canUndo: canUndo,
    );
  }
}
