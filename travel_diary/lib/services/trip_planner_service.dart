import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripPlannerService {
  Future<List<Map<String, dynamic>>> loadPlannedTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTrips = prefs.getStringList('plannedTrips') ?? [];
    return savedTrips
        .map((trip) => Map<String, dynamic>.from(jsonDecode(trip)))
        .toList();
  }

  Future<void> savePlannedTrips(List<Map<String, dynamic>> plannedTrips) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTrips = plannedTrips.map((trip) => jsonEncode(trip)).toList();
    await prefs.setStringList('plannedTrips', encodedTrips);
  }

  Future<void> addTrip(List<Map<String, dynamic>> plannedTrips, Map<String, dynamic> newTrip) async {
    plannedTrips.add(newTrip);
    await savePlannedTrips(plannedTrips);
  }

  Future<void> editTrip(List<Map<String, dynamic>> plannedTrips, int index, Map<String, dynamic> updatedTrip) async {
    plannedTrips[index] = updatedTrip;
    await savePlannedTrips(plannedTrips);
  }

  Future<void> deleteTrip(List<Map<String, dynamic>> plannedTrips, int index) async {
    plannedTrips.removeAt(index);
    await savePlannedTrips(plannedTrips);
  }
}
