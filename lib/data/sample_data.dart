import '../models/profile_model.dart';

/// Sample profile data for testing the Vibely app
class SampleData {
  static const ProfileModel sampleProfile = ProfileModel(
    id: '1',
    name: 'Priya',
    age: 26,
    distanceKm: 2.3,
    profilePhotoUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&h=1200&fit=crop',
    bio: 'Architect by day, jazz by night ✨\nLove spontaneous coffee plans',
    vibeMatchPercent: 92,
    stickers: [
      PersonalitySticker(emoji: '🧠', text: 'Deep Thinker'),
      PersonalitySticker(emoji: '☕', text: 'Coffee Lover'),
    ],
    heroImage: GalleryImage(
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&h=600&fit=crop',
      caption: 'Best weekend ever! 🌊',
      label: 'Recent Adventure!',
    ),
    galleryImages: [
      GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400&h=500&fit=crop',
        label: 'My Trek',
        caption: 'Escape Fort',
      ),
      GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=400&h=500&fit=crop',
        label: 'proud of',
        caption: 'My artwork',
      ),
    ],
    favoriteMovie: FavoriteMovie(
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
      title: 'Interstellar',
      comment: 'Space epic that makes you think...',
    ),
    favoriteSong: FavoriteSong(
      albumArtUrl:
          'https://i.scdn.co/image/ab67616d0000b273d6c0a7291e9a82f6e3e339f8',
      artist: 'Tame Impala',
      songTitle: 'The Less I Know The Better',
    ),
    favoriteFood: FavoriteFood(
      iconUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=200&h=200&fit=crop',
      name: 'Wood-fired Pizza',
    ),
  );

  /// List of sample profiles for testing multiple cards
  static List<ProfileModel> get sampleProfiles => [
    sampleProfile,
    ProfileModel(
      id: '2',
      name: 'Aisha',
      age: 24,
      distanceKm: 1.8,
      profilePhotoUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&h=1200&fit=crop',
      bio: 'Yoga instructor & plant mom 🌱\nSeeking good conversations',
      vibeMatchPercent: 88,
      stickers: [
        PersonalitySticker(emoji: '🧘', text: 'Zen Master'),
        PersonalitySticker(emoji: '📚', text: 'Book Worm'),
      ],
      heroImage: GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=600&fit=crop',
        caption: 'Mountain mornings ⛰️',
        label: 'Latest Trip',
      ),
      galleryImages: [
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=500&fit=crop',
          label: 'Yoga Life',
          caption: 'Morning flow',
        ),
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=400&h=500&fit=crop',
          label: 'My Plants',
          caption: 'Green family',
        ),
      ],
      favoriteMovie: FavoriteMovie(
        posterUrl:
            'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg',
        title: 'The Dark Knight',
        comment: 'A masterpiece of cinema',
      ),
      favoriteSong: FavoriteSong(
        albumArtUrl:
            'https://i.scdn.co/image/ab67616d0000b273e787cffec20aa2a396a61647',
        artist: 'Billie Eilish',
        songTitle: 'Everything I Wanted',
      ),
      favoriteFood: FavoriteFood(
        iconUrl:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200&h=200&fit=crop',
        name: 'Healthy Salad Bowl',
      ),
    ),
  ];
}
