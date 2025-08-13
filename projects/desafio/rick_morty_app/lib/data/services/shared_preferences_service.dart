import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _favoritesKey = 'favorite_characters';
  
  SharedPreferences? _prefs;
  
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  Future<List<String>> getFavoriteCharacterIds() async {
    await init();
    return _prefs?.getStringList(_favoritesKey) ?? [];
  }
  
  Future<bool> saveFavoriteCharacterIds(List<String> characterIds) async {
    await init();
    return _prefs?.setStringList(_favoritesKey, characterIds) ?? false;
  }
  
  Future<bool> addFavoriteCharacter(String characterId) async {
    final favorites = await getFavoriteCharacterIds();
    if (!favorites.contains(characterId)) {
      favorites.add(characterId);
      return await saveFavoriteCharacterIds(favorites);
    }
    return true;
  }
  
  Future<bool> removeFavoriteCharacter(String characterId) async {
    final favorites = await getFavoriteCharacterIds();
    favorites.remove(characterId);
    return await saveFavoriteCharacterIds(favorites);
  }
  
  Future<bool> isCharacterFavorite(String characterId) async {
    final favorites = await getFavoriteCharacterIds();
    return favorites.contains(characterId);
  }
  
  Future<bool> clearFavorites() async {
    await init();
    return _prefs?.remove(_favoritesKey) ?? false;
  }
}