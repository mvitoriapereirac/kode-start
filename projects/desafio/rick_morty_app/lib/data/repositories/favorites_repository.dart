import 'package:flutter/material.dart';
import 'package:rick_morty_app/data/services/shared_preferences_service.dart';
import 'package:rick_morty_app/domain/favorites_repository.dart';

class FavoritesRepo extends ChangeNotifier implements FavoritesRepository {
  final SharedPreferencesService _sharedPreferencesService;
  
  FavoritesRepo({required SharedPreferencesService sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService;
  
  @override
  Future<List<String>> getFavoriteCharacterIds() async {
    return await _sharedPreferencesService.getFavoriteCharacterIds();
  }
  
  @override
  Future<bool> addFavoriteCharacter(String characterId) async {
    return await _sharedPreferencesService.addFavoriteCharacter(characterId);
  }
  
  @override
  Future<bool> removeFavoriteCharacter(String characterId) async {
    return await _sharedPreferencesService.removeFavoriteCharacter(characterId);
  }
  
  @override
  Future<bool> isCharacterFavorite(String characterId) async {
    return await _sharedPreferencesService.isCharacterFavorite(characterId);
  }
  
  @override
  Future<bool> toggleFavoriteCharacter(String characterId) async {
    final isFavorite = await isCharacterFavorite(characterId);
    if (isFavorite) {
      return await removeFavoriteCharacter(characterId);
    }
    return await addFavoriteCharacter(characterId); 
  }
  
  @override
  Future<bool> clearFavorites() async {
    return await _sharedPreferencesService.clearFavorites();
  }
}