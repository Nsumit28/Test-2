import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';
import 'quick_view_screen.dart';
import 'vibe_gallery_screen.dart';
import 'favorites_screen.dart';

/// Main profile card page with PageView for 3 horizontal swipe screens
/// Contains AppBar, screens, progress indicator, and fixed CTAs with Bumble-style animations
class ProfileCardPage extends StatefulWidget {
  final ProfileModel profile;
  final VoidCallback? onVibeSignal;
  final VoidCallback? onSkip;
  final VoidCallback? onUndo;
  final bool canUndo;

  const ProfileCardPage({
    super.key,
    required this.profile,
    this.onVibeSignal,
    this.onSkip,
    this.onUndo,
    this.canUndo = false,
  });

  @override
  State<ProfileCardPage> createState() => _ProfileCardPageState();
}

class _ProfileCardPageState extends State<ProfileCardPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Timer state - starts at 3 hours (10800 seconds)
  Timer? _countdownTimer;
  int _remainingSeconds = 10800; // 3 hours = 3 * 60 * 60

  // Animation controllers
  late AnimationController _likeAnimationController;
  late AnimationController _skipAnimationController;
  late AnimationController _undoAnimationController;

  // Like animation values (3 phases: flash, shrink+heart, slide right)
  late Animation<double> _likeWhiteFlash;
  late Animation<double> _likeOverlayOpacity;
  late Animation<double> _likeIconScale;
  late Animation<double> _likeCardScale;
  late Animation<double> _likeCardOpacity;
  late Animation<double> _likeCardRotation;
  late Animation<double> _likeCardTranslateX;

  // Skip animation values
  late Animation<double> _skipOverlayOpacity;
  late Animation<double> _skipIconScale;
  late Animation<double> _skipCardTranslateX;
  late Animation<double> _skipCardOpacity;
  late Animation<double> _skipCardRotation;

  // Undo animation values
  late Animation<double> _undoCardTranslateX;
  late Animation<double> _undoCardOpacity;
  late Animation<double> _undoCardScale;

  bool _isAnimating = false;

  final List<String> _screenTitles = [
    'Quick View',
    'Vibe Gallery',
    'Favorites',
  ];

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Like Animation Controller (800ms total)
    // Phase 1: 0-150ms (white flash)
    // Phase 2: 150-350ms (shrink + heart overlay)
    // Phase 3: 350-800ms (slide right)
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Phase 1: White flash (0-150ms) - peaks at 100ms
    _likeWhiteFlash =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.8), weight: 60),
          TweenSequenceItem(tween: Tween(begin: 0.8, end: 0.0), weight: 40),
        ]).animate(
          CurvedAnimation(
            parent: _likeAnimationController,
            curve: const Interval(
              0.0,
              0.1875,
              curve: Curves.easeOut,
            ), // 0-150ms
          ),
        );

    // Phase 2: Card shrinks (150-350ms) - 1.0 → 0.85
    _likeCardScale = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(
          0.1875,
          0.4375,
          curve: Curves.easeOut,
        ), // 150-350ms
      ),
    );

    // Phase 2: Gradient overlay fades in (150-350ms) - 0% → 50%
    _likeOverlayOpacity = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(
          0.1875,
          0.4375,
          curve: Curves.easeOut,
        ), // 150-350ms
      ),
    );

    // Phase 2: Heart icon scales up (150-350ms) - 0.5 → 1.2 with bounce
    _likeIconScale = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(
          0.1875,
          0.4375,
          curve: Curves.elasticOut,
        ), // 150-350ms
      ),
    );

    // Phase 3: Card slides right (350-800ms) - 0 → 500px
    _likeCardTranslateX = Tween<double>(begin: 0.0, end: 500.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(
          0.4375,
          1.0,
          curve: Curves.easeInOut,
        ), // 350-800ms
      ),
    );

    // Phase 3: No rotation during slide (keep at 0)
    _likeCardRotation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(0.4375, 1.0, curve: Curves.easeOut),
      ),
    );

    // Phase 3: Card fades out (500-800ms) - 1.0 → 0.0
    _likeCardOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(0.625, 1.0, curve: Curves.easeOut), // 500-800ms
      ),
    );

    // Skip Animation Controller (500ms)
    _skipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _skipOverlayOpacity = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _skipAnimationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _skipIconScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _skipAnimationController,
        curve: const Interval(0.0, 0.3, curve: Curves.elasticOut),
      ),
    );

    _skipCardTranslateX = Tween<double>(begin: 0.0, end: -400.0).animate(
      CurvedAnimation(
        parent: _skipAnimationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _skipCardOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _skipAnimationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _skipCardRotation = Tween<double>(begin: 0.0, end: -0.14).animate(
      // -8 degrees in radians
      CurvedAnimation(
        parent: _skipAnimationController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Undo Animation Controller (600ms)
    _undoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _undoCardTranslateX = Tween<double>(begin: -400.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _undoAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _undoCardOpacity = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _undoAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _undoCardScale =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.05), weight: 60),
          TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 40),
        ]).animate(
          CurvedAnimation(
            parent: _undoAnimationController,
            curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
          ),
        );
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

  void _handleVibeSignal() async {
    if (_isAnimating) return;
    setState(() => _isAnimating = true);

    await _likeAnimationController.forward();
    _likeAnimationController.reset();

    setState(() => _isAnimating = false);
    widget.onVibeSignal?.call();
  }

  void _handleSkip() async {
    if (_isAnimating) return;
    setState(() => _isAnimating = true);

    await _skipAnimationController.forward();
    _skipAnimationController.reset();

    setState(() => _isAnimating = false);
    widget.onSkip?.call();
  }

  void _handleUndo() async {
    if (_isAnimating || !widget.canUndo) return;
    debugPrint('Undo tapped');
    widget.onUndo?.call();

    // Play undo animation after new profile loads
    await Future.delayed(const Duration(milliseconds: 50));
    await _undoAnimationController.forward();
    _undoAnimationController.reset();
  }

  void _handleSettings() {
    debugPrint('Settings/Filter tapped');
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pageController.dispose();
    _likeAnimationController.dispose();
    _skipAnimationController.dispose();
    _undoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VibelyColors.background,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _likeAnimationController,
          _skipAnimationController,
          _undoAnimationController,
        ]),
        builder: (context, child) {
          // Calculate transforms based on which animation is active
          double translateX = 0.0;
          double opacity = 1.0;
          double scale = 1.0;
          double rotation = 0.0;

          if (_likeAnimationController.isAnimating ||
              _likeAnimationController.value > 0) {
            translateX = _likeCardTranslateX.value; // Slide right
            scale = _likeCardScale.value;
            opacity = _likeCardOpacity.value;
            // No rotation for Like animation - slides straight
          } else if (_skipAnimationController.isAnimating ||
              _skipAnimationController.value > 0) {
            translateX = _skipCardTranslateX.value;
            opacity = _skipCardOpacity.value;
            rotation = _skipCardRotation.value;
          } else if (_undoAnimationController.isAnimating ||
              _undoAnimationController.value > 0) {
            translateX = _undoCardTranslateX.value;
            opacity = _undoCardOpacity.value;
            scale = _undoCardScale.value;
          }

          return Transform.translate(
            offset: Offset(translateX, 0),
            child: Transform.rotate(
              angle: rotation,
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Stack(
                    children: [
                      // Main content
                      Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
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
                                      VibeGalleryScreen(
                                        profile: widget.profile,
                                      ),
                                      FavoritesScreen(profile: widget.profile),
                                    ],
                                  ),
                                ),
                                _buildProgressIndicator(),
                              ],
                            ),
                          ),
                          _buildCTAButtons(),
                        ],
                      ),

                      // White flash overlay (Phase 1 of Like animation)
                      if (_likeAnimationController.isAnimating ||
                          _likeAnimationController.value > 0)
                        _buildWhiteFlashOverlay(),

                      // Like heart overlay (Phase 2-3 of Like animation)
                      if (_likeAnimationController.isAnimating ||
                          _likeAnimationController.value > 0)
                        _buildLikeOverlay(),

                      // Skip overlay
                      if (_skipAnimationController.isAnimating ||
                          _skipAnimationController.value > 0)
                        _buildSkipOverlay(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWhiteFlashOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          color: Colors.white.withValues(alpha: _likeWhiteFlash.value),
        ),
      ),
    );
  }

  Widget _buildLikeOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                VibelyColors.primary.withValues(
                  alpha: _likeOverlayOpacity.value * 1.25,
                ), // 50% max
                VibelyColors.secondary.withValues(
                  alpha: _likeOverlayOpacity.value * 1.25,
                ),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Transform.scale(
              scale: _likeIconScale.value,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('❤️', style: TextStyle(fontSize: 70)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4A5568).withValues(
                  alpha: _skipOverlayOpacity.value * 1.33,
                ), // Gray 600, 40% max
                const Color(0xFF718096).withValues(
                  alpha: _skipOverlayOpacity.value * 1.33,
                ), // Gray 400
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Transform.scale(
              scale: _skipIconScale.value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.close, color: Colors.white, size: 80),
                ),
              ),
            ),
          ),
        ),
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
              color: VibelyColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _formatTime(_remainingSeconds),
              style: VibelyTypography.label.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: VibelyColors.secondary,
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
          color: VibelyColors.textSecondary,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _handleSettings,
          icon: const Icon(
            Icons.tune,
            color: VibelyColors.textPrimary,
            size: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: widget.canUndo ? _handleUndo : null,
            icon: Icon(
              Icons.undo,
              color: widget.canUndo
                  ? VibelyColors.textPrimary
                  : VibelyColors.textSecondary.withOpacity(0.4),
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
            width: isActive ? 48 : 32,
            height: isActive ? 2 : 1.5,
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
                onTap: _isAnimating ? null : _handleSkip,
                child: AnimatedOpacity(
                  opacity: _isAnimating ? 0.5 : 1.0,
                  duration: const Duration(milliseconds: 150),
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
            ),
            const SizedBox(width: 16),

            // Vibe Signal Button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: _isAnimating ? null : _handleVibeSignal,
                child: AnimatedOpacity(
                  opacity: _isAnimating ? 0.5 : 1.0,
                  duration: const Duration(milliseconds: 150),
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
                      ],
                    ),
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
