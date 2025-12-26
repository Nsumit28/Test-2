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
    bio:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.✨',
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
    const ProfileModel(
      id: '2',
      name: 'Aisha',
      age: 24,
      distanceKm: 1.8,
      profilePhotoUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&h=1200&fit=crop',
      bio:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at lorem nec libero consectetur consectetur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia.',
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
    const ProfileModel(
      id: '3',
      name: 'Maya',
      age: 27,
      distanceKm: 3.5,
      profilePhotoUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&h=1200&fit=crop',
      bio:
          'Travel enthusiast ✈️ 25 countries and counting. Looking for my travel partner in crime.',
      vibeMatchPercent: 85,
      stickers: [
        PersonalitySticker(emoji: '✈️', text: 'Wanderlust'),
        PersonalitySticker(emoji: '📷', text: 'Photographer'),
      ],
      heroImage: GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&h=600&fit=crop',
        caption: 'Bali sunsets 🌅',
        label: 'Best Trip Ever',
      ),
      galleryImages: [
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1530521954074-e64f6810b32d?w=400&h=500&fit=crop',
          label: 'Japan',
          caption: 'Cherry blossoms',
        ),
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?w=400&h=500&fit=crop',
          label: 'Paris',
          caption: 'City of love',
        ),
      ],
      favoriteMovie: FavoriteMovie(
        posterUrl:
            'https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg',
        title: 'Schindler\'s List',
        comment: 'A powerful story',
      ),
      favoriteSong: FavoriteSong(
        albumArtUrl:
            'https://i.scdn.co/image/ab67616d0000b2734121faee8df82c526cbab2be',
        artist: 'Coldplay',
        songTitle: 'Yellow',
      ),
      favoriteFood: FavoriteFood(
        iconUrl:
            'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=200&h=200&fit=crop',
        name: 'Sushi Platter',
      ),
    ),
    const ProfileModel(
      id: '4',
      name: 'Zara',
      age: 25,
      distanceKm: 0.8,
      profilePhotoUrl:
          'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=800&h=1200&fit=crop',
      bio:
          'Startup founder by day, salsa dancer by night 💃 Life is too short to be boring.',
      vibeMatchPercent: 94,
      stickers: [
        PersonalitySticker(emoji: '💼', text: 'Entrepreneur'),
        PersonalitySticker(emoji: '💃', text: 'Dancer'),
      ],
      heroImage: GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1504609773096-104ff2c73ba4?w=800&h=600&fit=crop',
        caption: 'Startup life 🚀',
        label: 'Office Vibes',
      ),
      galleryImages: [
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400&h=500&fit=crop',
          label: 'Dancing',
          caption: 'Salsa night',
        ),
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=400&h=500&fit=crop',
          label: 'Team',
          caption: 'My startup fam',
        ),
      ],
      favoriteMovie: FavoriteMovie(
        posterUrl:
            'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg',
        title: 'Avengers: Endgame',
        comment: 'Epic conclusion',
      ),
      favoriteSong: FavoriteSong(
        albumArtUrl:
            'https://i.scdn.co/image/ab67616d0000b273b1c4b76e23414c9f20242268',
        artist: 'Dua Lipa',
        songTitle: 'Levitating',
      ),
      favoriteFood: FavoriteFood(
        iconUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&h=200&fit=crop',
        name: 'Gourmet Burger',
      ),
    ),
    const ProfileModel(
      id: '5',
      name: 'Neha',
      age: 28,
      distanceKm: 5.2,
      profilePhotoUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800&h=1200&fit=crop',
      bio:
          'Doctor saving lives 🏥 Weekend chef experimenting with fusion cuisine. Science nerd at heart.',
      vibeMatchPercent: 79,
      stickers: [
        PersonalitySticker(emoji: '🩺', text: 'Healer'),
        PersonalitySticker(emoji: '👩‍🍳', text: 'Home Chef'),
      ],
      heroImage: GalleryImage(
        imageUrl:
            'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=600&fit=crop',
        caption: 'Cooking experiments 🍳',
        label: 'Kitchen Adventures',
      ),
      galleryImages: [
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=500&fit=crop',
          label: 'Hospital',
          caption: 'Work life',
        ),
        GalleryImage(
          imageUrl:
              'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&h=500&fit=crop',
          label: 'Cooking',
          caption: 'My creations',
        ),
      ],
      favoriteMovie: FavoriteMovie(
        posterUrl:
            'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        title: 'The Godfather',
        comment: 'Classic storytelling',
      ),
      favoriteSong: FavoriteSong(
        albumArtUrl:
            'https://i.scdn.co/image/ab67616d0000b2738b32b139981e79f6f0da7b5f',
        artist: 'Ed Sheeran',
        songTitle: 'Perfect',
      ),
      favoriteFood: FavoriteFood(
        iconUrl:
            'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=200&h=200&fit=crop',
        name: 'Butter Chicken',
      ),
    ),
  ];
}
