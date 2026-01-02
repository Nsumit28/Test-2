import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../constants/colors.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeVideo();
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

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 80),

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
