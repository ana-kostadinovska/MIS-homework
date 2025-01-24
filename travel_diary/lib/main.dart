import 'package:flutter/material.dart';
import 'package:travel_diary/screens/destinations.dart';
import 'package:travel_diary/screens/favorites.dart';
import 'package:travel_diary/screens/home.dart';
import 'package:travel_diary/screens/tripPlanner.dart';

void main() {
  runApp(const TravelDiaryApp());
}

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/destinations': (context) => DestinationsScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/trip-planner': (context) => TripPlannerScreen(),
      },
    );
  }
}