import 'package:flutter/material.dart';
import 'package:travel_diary/screens/login.dart';

import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
          title: Text('Travel Diary',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text('Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.travel_explore),
              title: Text('Travel Destinations'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/destinations');
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Trip Planner'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/trip-planner');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://anjahome.com/wp-content/uploads/2021/06/travel-diary-scrapbooking-ideas.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Text('Welcome to your Travel Diary!',
                    style: TextStyle(
                      color: Colors.deepPurple[50],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/destinations');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('View Destinations'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
