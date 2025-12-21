import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';

/// Screen 3: Favorites
/// Horizontal carousels for Movie, Song, and Drinks sections
class FavoritesScreen extends StatelessWidget {
  final ProfileModel profile;

  const FavoritesScreen({super.key, required this.profile});

  // Sample movie poster URLs (10 items)
  static const List<String> _moviePosters = [
    'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BMTQzMTcwNTI2M15BMl5BanBnXkFtZTcwNTM5MTQ2Mw@@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BOTE4NzM1MjAxNl5BMl5BanBnXkFtZTcwNDczMTEyMQ@@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
    'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNjU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg',
  ];

  // Sample album art URLs (10 items)
  static const List<String> _albumArts = [
    'https://i.scdn.co/image/ab67616d0000b273d6c0a7291e9a82f6e3e339f8',
    'https://i.scdn.co/image/ab67616d0000b273e787cffec20aa2a396a61647',
    'https://i.scdn.co/image/ab67616d0000b2734121faee8df82c526cbab2be',
    'https://i.scdn.co/image/ab67616d0000b273b1c4b76e23414c9f20242268',
    'https://i.scdn.co/image/ab67616d0000b2738b32b139981e79f6f0da7b5f',
    'https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96',
    'https://i.scdn.co/image/ab67616d0000b27350a3147b4edd73d985f0b0db',
    'https://i.scdn.co/image/ab67616d0000b2731624590458126fc8b8c64c2f',
    'https://i.scdn.co/image/ab67616d0000b273407bd04707c463bbb3410737',
    'https://i.scdn.co/image/ab67616d0000b2739e495fb707973f3390850eea',
  ];

  // Sample drink images URLs (10 items)
  static const List<String> _drinkImages = [
    'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1536935338788-846bb9981813?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1497534446932-c925b458314e?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1587223962930-cb7f31384c19?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1609951651556-5334e2706168?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1546171753-97d7676e4602?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1507120878965-54b2d3939100?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1582106245687-cbb466a9f07f?w=200&h=200&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Section
          _buildSectionHeader('🎬 Movies/Series'),
          const SizedBox(height: 12),
          _buildMovieCarousel(),
          const SizedBox(height: 24),

          // Song Section
          _buildSectionHeader('🎵 Songs'),
          const SizedBox(height: 12),
          _buildSongCarousel(),
          const SizedBox(height: 24),

          // Drinks Section
          _buildSectionHeader('🍸 Drinks'),
          const SizedBox(height: 12),
          _buildDrinksCarousel(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: VibelyTypography.sectionHeader.copyWith(
          color: VibelyColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildMovieCarousel() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16),
        itemCount: _moviePosters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == _moviePosters.length - 1 ? 16 : 12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: _moviePosters[index],
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 120,
                  height: 180,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 120,
                  height: 180,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.movie, size: 40),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSongCarousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16),
        itemCount: _albumArts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == _albumArts.length - 1 ? 16 : 12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: _albumArts[index],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 100,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 100,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.music_note, size: 32),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrinksCarousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16),
        itemCount: _drinkImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == _drinkImages.length - 1 ? 16 : 12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: _drinkImages[index],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 100,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 100,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.local_bar, size: 32),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
