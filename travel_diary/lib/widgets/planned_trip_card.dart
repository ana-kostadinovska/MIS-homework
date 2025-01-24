import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlannedTripCard extends StatelessWidget {
  final Map<String, dynamic> trip;
  final Function onEdit;
  final Function onDelete;

  PlannedTripCard({required this.trip, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(trip['destination'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(trip['startDate']))}'),
            Text('To: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(trip['endDate']))}'),
            Text('Budget: ${trip['budget']}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit, color: Colors.deepPurple),
              onPressed: () => onEdit(),
            ),
            IconButton(icon: Icon(Icons.delete, color: Colors.red[300]),
              onPressed: () => onDelete(),
            ),
          ],
        ),
      ),
    );
  }
}
