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

  final List<String> _screenTitles = [
    'Quick View',
    'Vibe Gallery',
    'Favorites',
  ];
  final List<String> _vibeNames = [
    '☕ Coffee Vibe',
    "Priya's Vibe",
    "Priya's Favorites",
  ];

  @override
  void dispose() {
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
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: Text(
            _vibeNames[_currentPage],
            style: VibelyTypography.label.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      leadingWidth: 140,
      title: Text(
        _screenTitles[_currentPage],
        style: VibelyTypography.label.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: VibelyColors.textSecondary,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.close,
            color: VibelyColors.textPrimary,
            size: 24,
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
            width: isActive ? 60 : 40,
            height: isActive ? 3 : 2,
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
