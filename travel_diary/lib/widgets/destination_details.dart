import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationDetails extends StatelessWidget {
  final Destination destination;

  DestinationDetails({required this.destination});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: Image.network(
              destination.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(destination.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      '${destination.city}, ${destination.country}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  destination.description,
                  style: TextStyle(fontSize: 16, height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(Icons.calendar_today, "Best time", destination.bestTime),
                    _buildDetailItem(Icons.cloud, "Weather", destination.weather),
                    _buildDetailItem(Icons.attach_money, "Budget", destination.budget),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepPurple),
        SizedBox(height: 5),
        Text(label,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
