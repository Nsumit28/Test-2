import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';
import 'quick_view_screen.dart';
import 'vibe_gallery_screen.dart';
import 'favorites_screen.dart';

/// Main profile card page with PageView for 3 horizontal swipe screens
/// Contains AppBar, screens, progress indicator, and fixed CTAs
class ProfileCardPage extends StatefulWidget {
  final ProfileModel profile;

  const ProfileCardPage({super.key, required this.profile});

  @override
  State<ProfileCardPage> createState() => _ProfileCardPageState();
}

class _ProfileCardPageState extends State<ProfileCardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Timer state - starts at 3 hours (10800 seconds)
  Timer? _countdownTimer;
  int _remainingSeconds = 10800; // 3 hours = 3 * 60 * 60

  final List<String> _screenTitles = [
    'Quick View',
    'Vibe Gallery',
    'Favorites',
  ];

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VibelyColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Main content with PageView
          Expanded(
            child: Column(
              children: [
                // PageView screens
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      QuickViewScreen(profile: widget.profile),
                      VibeGalleryScreen(profile: widget.profile),
                      FavoritesScreen(profile: widget.profile),
                    ],
                  ),
                ),

                // Progress Indicator
                _buildProgressIndicator(),
              ],
            ),
          ),

          // Fixed CTA Buttons
          _buildCTAButtons(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: 120,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: VibelyColors.cardBackground, // Soft Peach #FFF5F0
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _formatTime(_remainingSeconds),
              style: VibelyTypography.label.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: VibelyColors.secondary, // Sunset Orange #E68161
              ),
            ),
          ),
        ),
      ),
      title: Text(
        _screenTitles[_currentPage],
        style: VibelyTypography.label.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: VibelyColors.textSecondary, // Slate Medium #626C71
        ),
      ),
      actions: [
        // Settings/Filter Icon
        IconButton(
          onPressed: () {
            debugPrint('Settings/Filter tapped');
          },
          icon: const Icon(
            Icons.tune,
            color: VibelyColors.textPrimary, // Deep Espresso #1F2121
            size: 24,
          ),
        ),
        // Undo Icon
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              debugPrint('Undo tapped');
            },
            icon: const Icon(
              Icons.undo,
              color: VibelyColors.textPrimary, // Deep Espresso #1F2121
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = index == _currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: isActive ? 48 : 32, // Updated: 60→48, 40→32
            height: isActive ? 2 : 1.5, // Updated: 3→2, 2→1.5
            decoration: BoxDecoration(
              color: isActive
                  ? VibelyColors.secondary
                  : VibelyColors.progressInactive,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCTAButtons() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Skip Button
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // Handle skip action
                  debugPrint('Skip tapped');
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: VibelyColors.borderGray,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.close,
                        color: VibelyColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Skip',
                        style: VibelyTypography.button.copyWith(
                          color: VibelyColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Vibe Signal Button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  // Handle vibe signal action
                  debugPrint('Vibe Signal tapped');
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: VibelyColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vibe Signal',
                        style: VibelyTypography.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '〜',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
