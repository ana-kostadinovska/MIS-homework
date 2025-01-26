import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/favorites_service.dart';
import '../widgets/favorite_card.dart';
import '../services/auth_service.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Destination> favoriteDestinations = [];
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _initializeFavorites();
  }

  Future<void> _initializeFavorites() async {
    userEmail = await AuthService().getEmail();
    if (userEmail != null) {
      _loadFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    if (userEmail == null) return;

    List<String> favoriteNames = await FavoritesService.loadFavorites(userEmail!);
    List<Destination> allDestinations = destinations;
    List<Destination> favorites = allDestinations.where((d) => favoriteNames.contains(d.name)).toList();

    setState(() {
      favoriteDestinations = favorites;
    });
  }

  Future<void> _removeFromFavorites(String name) async {
    if (userEmail != null) {
      await FavoritesService.removeFavorite(userEmail!, name);
      _loadFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.grey[800]),
            onSelected: (value) {
              switch (value) {
                case 'Home':
                  Navigator.pushNamed(context, '/');
                  break;
                case 'Travel Destinations':
                  Navigator.pushNamed(context, '/destinations');
                  break;
                case 'Trip Planner':
                  Navigator.pushNamed(context, '/trip-planner');
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Home',
                  child: Row(
                    children: [
                      Icon(Icons.home, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text('Home'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Travel Destinations',
                  child: Row(
                    children: [
                      Icon(Icons.travel_explore, color: Colors.green[800]),
                      SizedBox(width: 8),
                      Text('Travel Destinations'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Trip Planner',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Trip Planner'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favoriteDestinations.isEmpty
          ? const Center(
        child: Text(
          'No favorites added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteDestinations.length,
        itemBuilder: (context, index) {
          final destination = favoriteDestinations[index];
          return FavoriteCard(
            destination: destination,
            onRemove: () async {
              await _removeFromFavorites(destination.name);
              if (favoriteDestinations.isEmpty) {
                Navigator.pop(context, true);
              }
            },
          );
        },
      ),
    );
  }
}
