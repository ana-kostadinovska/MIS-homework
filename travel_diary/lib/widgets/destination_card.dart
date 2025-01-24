import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';
import '../screens/destinationDetails.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;

  DestinationCard({required this.destination});

  @override
  _DestinationCardState createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteDestinations = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavorite = favoriteDestinations.contains(widget.destination.name);
    });
  }

  _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteDestinations = prefs.getStringList('favorites') ?? [];

    if (isFavorite) {
      favoriteDestinations.remove(widget.destination.name);
    } else {
      favoriteDestinations.add(widget.destination.name);
    }

    await prefs.setStringList('favorites', favoriteDestinations);

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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.destination.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('${widget.destination.city}, ${widget.destination.country}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5),
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
