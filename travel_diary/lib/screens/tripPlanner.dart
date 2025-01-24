import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/destination.dart';
import '../widgets/planned_trip_card.dart';
import '../services/trip_planner_service.dart';

class TripPlannerScreen extends StatefulWidget {
  @override
  _TripPlannerScreenState createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final TripPlannerService _tripPlannerService = TripPlannerService();
  List<Map<String, dynamic>> _plannedTrips = [];
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  Destination? _selectedDestination;
  final TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlannedTrips();
  }

  Future<void> _loadPlannedTrips() async {
    final trips = await _tripPlannerService.loadPlannedTrips();
    setState(() {
      _plannedTrips = trips;
    });
  }

  Future<void> _addTrip() async {
    if (_selectedDestination == null ||
        _selectedStartDate == null ||
        _selectedEndDate == null ||
        _budgetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields!')),
      );
      return;
    }

    final newTrip = {
      'destination': _selectedDestination!.name,
      'startDate': _selectedStartDate!.toIso8601String(),
      'endDate': _selectedEndDate!.toIso8601String(),
      'budget': _budgetController.text,
    };

    await _tripPlannerService.addTrip(_plannedTrips, newTrip);
    _loadPlannedTrips();

    _selectedStartDate = null;
    _selectedEndDate = null;
    _selectedDestination = null;
    _budgetController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Trip added successfully!')),
    );
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = pickedDate;
        } else {
          _selectedEndDate = pickedDate;
        }
      });
    }
  }

  void _editTrip(int index) {
    final trip = _plannedTrips[index];

    String? updatedBudget = trip['budget'];
    Destination? updatedDestination = destinations.firstWhere(
          (d) => d.name == trip['destination'],
      orElse: () => Destination(name: 'Unknown', city: '', country: '', location: '', imageUrl: '', weather: '', bestTime: '', description: '', budget: ''),
    );

    DateTime? updatedStartDate = DateTime.parse(trip['startDate']);
    DateTime? updatedEndDate = DateTime.parse(trip['endDate']);

    TextEditingController _budgetController = TextEditingController(text: updatedBudget);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text('Edit Trip'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButton<Destination>(
                      value: updatedDestination,
                      hint: Text('Select Destination'),
                      items: destinations.map((destination) {
                        return DropdownMenuItem(
                          value: destination,
                          child: Text(destination.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          updatedDestination = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: updatedStartDate!,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                setDialogState(() {
                                  updatedStartDate = date;
                                });
                              }
                            },
                            child: Text(
                              'Start: ${DateFormat('yyyy-MM-dd').format(updatedStartDate!)}',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: updatedEndDate!,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                setDialogState(() {
                                  updatedEndDate = date;
                                });
                              }
                            },
                            child: Text(
                              'End: ${DateFormat('yyyy-MM-dd').format(updatedEndDate!)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _budgetController,
                      decoration: InputDecoration(
                        labelText: 'Budget',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        updatedBudget = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await _tripPlannerService.editTrip(
                      _plannedTrips, index, {
                        'destination': updatedDestination!.name,
                      'startDate': updatedStartDate!.toIso8601String(),
                      'endDate': updatedEndDate!.toIso8601String(),
                      'budget': updatedBudget,
                    },);
                    _loadPlannedTrips();
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteTrip(int index) async {
    await _tripPlannerService.deleteTrip(_plannedTrips, index);
    _loadPlannedTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trip Planner',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.grey[800]),
            onSelected: (value) {
              switch (value) {
                case 'Home':
                  Navigator.pushNamed(context, '/');
                  break;
                case 'Travel Destinations':
                  Navigator.pushNamed(context, '/destinations');
                  break;
                case 'Favorites':
                  Navigator.pushNamed(context, '/favorites');
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
                  value: 'Travel Destinations',
                  child: Row(
                    children: [
                      Icon(Icons.travel_explore, color: Colors.green[800]),
                      SizedBox(width: 8),
                      Text('Travel Destinations'),
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
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Destination>(
              value: _selectedDestination,
              hint: Text('Select Destination'),
              items: destinations.map((destination) {
                return DropdownMenuItem(
                  value: destination,
                  child: Text(destination.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDestination = value;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _pickDate(isStartDate: true),
                    child: Text(
                      _selectedStartDate == null
                          ? 'Select Start Date'
                          : 'Start: ${DateFormat('yyyy-MM-dd').format(_selectedStartDate!)}',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => _pickDate(isStartDate: false),
                    child: Text(_selectedEndDate == null ? 'Select End Date' : 'End: ${DateFormat('yyyy-MM-dd').format(_selectedEndDate!)}',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(
                labelText: 'Budget',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTrip,
              child: Text('Add Trip'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _plannedTrips.length,
                itemBuilder: (context, index) {
                  final trip = _plannedTrips[index];
                  return PlannedTripCard(
                    trip: trip,
                    onEdit: () => _editTrip(index),
                    onDelete: () => _deleteTrip(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
