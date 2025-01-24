import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

class DestinationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Travel Destinations',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(color: Colors.deepPurple),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.grey[800]),
            onSelected: (value) {
              switch (value) {
                case 'Home':
                  Navigator.pushNamed(context, '/');
                  break;
                case 'Favorites':
                  Navigator.pushNamed(context, '/favorites');
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
                  value: 'Favorites',
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Favorites'),
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
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return DestinationCard(destination: destination);
        },
      ),
    );
  }
}

