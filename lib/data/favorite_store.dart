import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStore {
  static const String _key = 'favorite_event_ids';

  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []).toSet();
  }

  static Future<void> toggleFavorite(String eventId) async {
    final favorites = await getFavorites();
    if (!favorites.add(eventId)) favorites.remove(eventId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, favorites.toList());
  }
}
