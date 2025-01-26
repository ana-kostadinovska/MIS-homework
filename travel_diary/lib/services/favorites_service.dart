import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static Future<List<String>> loadFavorites(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites_$email') ?? [];
  }

  static Future<void> saveFavorites(String email, List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites_$email', favorites);
  }

  static Future<void> addFavorite(String email, String name) async {
    List<String> favorites = await loadFavorites(email);
    if (!favorites.contains(name)) {
      favorites.add(name);
      await saveFavorites(email, favorites);
    }
  }

  static Future<void> removeFavorite(String email, String name) async {
    List<String> favorites = await loadFavorites(email);
    if (favorites.contains(name)) {
      favorites.remove(name);
      await saveFavorites(email, favorites);
    }
  }
}
