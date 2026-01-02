import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

/// End-of-Queue Screen
/// Shows when user has swiped through all available profiles
/// Displays calming circular video with encouraging message and CTA
class EndOfQueueScreen extends StatefulWidget {
  final VoidCallback? onAdjustFilters;

  const EndOfQueueScreen({super.key, this.onAdjustFilters});

  @override
  State<EndOfQueueScreen> createState() => _EndOfQueueScreenState();
}

class _EndOfQueueScreenState extends State<EndOfQueueScreen> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;

  // Timer state - continues from where it left off (starts at 3 hours)
  Timer? _countdownTimer;
  int _remainingSeconds = 10800; // 3 hours = 3 * 60 * 60

  @override
  void initState() {
    super.initState();
    _initializeVideo();
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

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.asset(
        'assets/videos/caught_up_animation.mp4',
      );

      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.setVolume(0.0); // Muted
      _videoController!.play();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Video load error: $e');
      if (mounted) {
        setState(() {
          _hasVideoError = true;
        });
      }
    }
  }

  void _handleSettings() {
    debugPrint('Settings/Filter tapped');
    widget.onAdjustFilters?.call();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Circular Video Container
              _buildCircularVideo(),

              const SizedBox(height: 40),

              // Title
              const Text(
                "You're All Caught Up!",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1810), // Deep Espresso
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description
              const Text(
                'Great work exploring! Adjust your filters to discover more people who match your vibe.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B6B6B), // Slate Medium
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // CTA Button
              _buildAdjustFiltersButton(),

              const SizedBox(height: 60),
            ],
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
      // Timer on the left
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
      // No title (page name omitted per request)
      title: null,
      // Filter and Undo icons on the right
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
            onPressed: null, // Always inactive on this screen
            icon: Icon(
              Icons.undo,
              color: VibelyColors.textSecondary.withValues(alpha: 0.4),
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularVideo() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: VibelyColors.cardBackground,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(child: _buildVideoContent()),
    );
  }

  Widget _buildVideoContent() {
    if (_hasVideoError) {
      // Fallback: Show relaxing illustration
      return Container(
        color: VibelyColors.cardBackground,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏖️', style: TextStyle(fontSize: 80)),
              SizedBox(height: 8),
              Text('🐱', style: TextStyle(fontSize: 40)),
            ],
          ),
        ),
      );
    }

    if (!_isVideoInitialized) {
      // Loading state
      return Container(
        color: VibelyColors.cardBackground,
        child: const Center(
          child: CircularProgressIndicator(
            color: VibelyColors.secondary,
            strokeWidth: 2,
          ),
        ),
      );
    }

    // Video player
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoController!.value.size.width,
          height: _videoController!.value.size.height,
          child: VideoPlayer(_videoController!),
        ),
      ),
    );
  }

  Widget _buildAdjustFiltersButton() {
    return GestureDetector(
      onTap: () {
        debugPrint('Adjust My Filters tapped');
        widget.onAdjustFilters?.call();
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF6B6B), // Coral Burst
              Color(0xFFFFA500), // Sunset Orange
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Adjust My Filters',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
