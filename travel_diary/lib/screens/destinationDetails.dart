import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_details.dart';

class DestinationDetailsScreen extends StatelessWidget {
  final Destination destination;

  DestinationDetailsScreen({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(destination.name,
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: DestinationDetails(destination: destination),
    );
  }
}
