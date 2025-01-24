import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String favoritesKey = 'favorites';

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey) ?? [];
  }

  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<void> addFavorite(String name) async {
    List<String> favorites = await loadFavorites();
    if (!favorites.contains(name)) {
      favorites.add(name);
      await saveFavorites(favorites);
    }
  }

  static Future<void> removeFavorite(String name) async {
    List<String> favorites = await loadFavorites();
    if (favorites.contains(name)) {
      favorites.remove(name);
      await saveFavorites(favorites);
    }
  }
}
