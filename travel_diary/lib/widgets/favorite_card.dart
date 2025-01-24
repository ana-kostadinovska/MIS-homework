import 'package:flutter/material.dart';
import '../models/destination.dart';

class FavoriteCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onRemove;

  FavoriteCard({required this.destination, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                destination.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(destination.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('${destination.city}, ${destination.country}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: onRemove,
              icon: Icon(Icons.delete_forever_rounded, color: Colors.red[300]),
            ),
          ],
        ),
      ),
    );
  }
}
