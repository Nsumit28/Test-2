import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/profile_card_page.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
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
      home: const MainNavigationPage(),
    );
  }
}

/// Main navigation page with bottom navigation bar
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentTabIndex = 1; // Default to Vibe tab (center)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: const [
          ProfileScreen(), // Index 0 - Left
          VibeScreen(), // Index 1 - Center (default)
          ChatScreen(), // Index 2 - Right
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 72 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // NEW ORDER: Profile (left) | Vibe (center) | Chat (right)
              _buildNavItem(
                index: 0,
                activeIcon: Icons.person,
                inactiveIcon: Icons.person_outline,
                label: 'Profile',
              ),
              _buildCenterNavItem(),
              _buildNavItem(
                index: 2,
                activeIcon: Icons.chat_bubble,
                inactiveIcon: Icons.chat_bubble_outline,
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
  }) {
    final isActive = _currentTabIndex == index;
    final color = isActive
        ? VibelyColors
              .secondary // #E68161 (Sunset Orange)
        : const Color(0xFF9CA3AF); // Slate Medium

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTabIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : inactiveIcon,
                key: ValueKey(isActive),
                size: 28,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem() {
    final isActive = _currentTabIndex == 1;
    final color = isActive
        ? VibelyColors
              .secondary // #E68161 (Sunset Orange)
        : const Color(0xFF9CA3AF); // Slate Medium

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTabIndex = 1;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              child: Image.asset(
                'assets/images/vibely_logo.png',
                width: 28,
                height: 28,
                color: color, // Tint the logo
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to grid icon if logo missing
                  return Icon(Icons.grid_view_rounded, size: 28, color: color);
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Vibe',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vibe Screen - Profile card browsing with navigation
class VibeScreen extends StatefulWidget {
  const VibeScreen({super.key});

  @override
  State<VibeScreen> createState() => _VibeScreenState();
}

class _VibeScreenState extends State<VibeScreen> {
  final List<ProfileModel> _profiles = SampleData.sampleProfiles;
  int _currentProfileIndex = 0;
  final List<int> _skippedProfiles = [];

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCardPage(
      key: ValueKey(currentProfile.id),
      profile: currentProfile,
      onVibeSignal: _onVibeSignal,
      onSkip: _onSkip,
      onUndo: _onUndo,
      canUndo: canUndo,
    );
  }
}
