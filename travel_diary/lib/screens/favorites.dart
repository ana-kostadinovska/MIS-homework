import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/favorites_service.dart';
import '../widgets/favorite_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Destination> favoriteDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<String> favoriteNames = await FavoritesService.loadFavorites();

    List<Destination> allDestinations = destinations;
    List<Destination> favorites = allDestinations.where((d) => favoriteNames.contains(d.name)).toList();

    setState(() {
      favoriteDestinations = favorites;
    });
  }

  Future<void> _removeFromFavorites(String name) async {
    await FavoritesService.removeFavorite(name);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      ),
      body: favoriteDestinations.isEmpty
          ? Center(
        child: Text('No favorites added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteDestinations.length,
        itemBuilder: (context, index) {
          final destination = favoriteDestinations[index];
          return FavoriteCard(
            destination: destination,
            onRemove: () => _removeFromFavorites(destination.name),
          );
        },
      ),
    );
  }
}
