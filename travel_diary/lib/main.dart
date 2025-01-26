import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diary/providers/provider.dart';
import 'package:travel_diary/screens/destinations.dart';
import 'package:travel_diary/screens/favorites.dart';
import 'package:travel_diary/screens/home.dart';
import 'package:travel_diary/screens/register.dart';
import 'package:travel_diary/screens/tripPlanner.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
      ],
      child: TravelDiaryApp(),
    ),
  );
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
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterScreen(),
        '/': (context) => HomeScreen(),
        '/destinations': (context) => DestinationsScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/trip-planner': (context) => TripPlannerScreen(),
      },
    );
  }
}