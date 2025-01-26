import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripPlannerService {
  Future<List<Map<String, dynamic>>> loadPlannedTrips(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTrips = prefs.getStringList('plannedTrips_$userEmail') ?? [];
    return savedTrips
        .map((trip) => Map<String, dynamic>.from(jsonDecode(trip)))
        .toList();
  }

  Future<void> savePlannedTrips(String userEmail, List<Map<String, dynamic>> plannedTrips) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTrips = plannedTrips.map((trip) => jsonEncode(trip)).toList();
    await prefs.setStringList('plannedTrips_$userEmail', encodedTrips);
  }

  Future<void> addTrip(String userEmail, List<Map<String, dynamic>> plannedTrips, Map<String, dynamic> newTrip) async {
    plannedTrips.add(newTrip);
    await savePlannedTrips(userEmail, plannedTrips);
  }

  Future<void> editTrip(String userEmail, List<Map<String, dynamic>> plannedTrips, int index, Map<String, dynamic> updatedTrip) async {
    plannedTrips[index] = updatedTrip;
    await savePlannedTrips(userEmail, plannedTrips);
  }

  Future<void> deleteTrip(String userEmail, List<Map<String, dynamic>> plannedTrips, int index) async {
    plannedTrips.removeAt(index);
    await savePlannedTrips(userEmail, plannedTrips);
  }
}

