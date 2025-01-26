import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';
import '../screens/destinationDetails.dart';
import '../services/auth_service.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;

  DestinationCard({required this.destination});

  @override
  _DestinationCardState createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  bool isFavorite = false;
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

    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteDestinations = prefs.getStringList('favorites_$userEmail') ?? [];

    setState(() {
      isFavorite = favoriteDestinations.contains(widget.destination.name);
    });
  }

  Future<void> _toggleFavorite() async {
    if (userEmail == null) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteDestinations = prefs.getStringList('favorites_$userEmail') ?? [];

    if (isFavorite) {
      favoriteDestinations.remove(widget.destination.name);
    } else {
      favoriteDestinations.add(widget.destination.name);
    }

    await prefs.setStringList('favorites_$userEmail', favoriteDestinations);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailsScreen(
              destination: widget.destination,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                widget.destination.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 420,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destination.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${widget.destination.city}, ${widget.destination.country}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

