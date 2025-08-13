import 'package:flutter/material.dart';

abstract class FavoritesRepository implements ChangeNotifier {
  Future<List<String>> getFavoriteCharacterIds();
  Future<bool> addFavoriteCharacter(String characterId);
  Future<bool> removeFavoriteCharacter(String characterId);
  Future<bool> isCharacterFavorite(String characterId);
  Future<bool> toggleFavoriteCharacter(String characterId);
  Future<bool> clearFavorites();
}