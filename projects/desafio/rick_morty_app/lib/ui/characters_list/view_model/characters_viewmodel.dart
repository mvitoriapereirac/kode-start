import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/favorites_repository.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepo;
  final FavoritesRepository _favoritesRepo;

  CharactersViewModel({
    required CharacterRepository characterRepo,
    required FavoritesRepository favoritesRepo
  }) : _characterRepo = characterRepo, _favoritesRepo = favoritesRepo;

  List<Character> characters = [];
  int _currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String errorMessage = '';
  List<Character> relatedCharacters = [];
  
  bool _showOnlyFavorites = false;
  bool get showOnlyFavorites => _showOnlyFavorites;

  List<Character> get filteredCharacters {
    if (_showOnlyFavorites) {
       return characters.where((character) => character.isFavorite).toList();
    }
    return characters;
  }
  

  void toggleFavoritesFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  Future<void> getCharactersList(int? page) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    final newCharacters = await _characterRepo.getCharactersList(page);
    
    if (newCharacters.error != null) {
      errorMessage = newCharacters.error!;
      toggleLoading(false);
      return;
    }

    if (newCharacters.data == null) {
      toggleLoading(false);
      return;
    }

    characters.addAll(newCharacters.data!);
    
    await _updateFavoriteStatus();
    
    _currentPage = page ?? _currentPage;
    _currentPage++;
    
    toggleLoading(true);
  }

  Future<void> _updateFavoriteStatus() async {
    try {
      final favoriteIds = await _favoritesRepo.getFavoriteCharacterIds();
      for (int i = 0; i < characters.length; i++) {

        final isFavorite = favoriteIds.contains(characters[i].id.toString());
        characters[i] = characters[i].copyWith(isFavorite: isFavorite);
      }
      
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<bool> toggleFavorite(Character character) async {
    try {
      final success = await _favoritesRepo.toggleFavoriteCharacter(character.id.toString());
      
      if (success) {
        final index = characters.indexWhere((c) => c.id == character.id);
        if (index != -1) {
          characters[index] = characters[index].copyWith(
            isFavorite: !characters[index].isFavorite
          );
          notifyListeners();
        }
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isCharacterFavorite(String characterId) async {
    try {
      return await _favoritesRepo.isCharacterFavorite(characterId);
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToFavorites(Character character) async {
    try {
      final success = await _favoritesRepo.addFavoriteCharacter(character.id.toString());
      
      if (success) {
        final index = characters.indexWhere((c) => c.id == character.id);
        if (index != -1) {
          characters[index] = characters[index].copyWith(isFavorite: true);
          notifyListeners();
        }
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavorites(Character character) async {
    try {
      final success = await _favoritesRepo.removeFavoriteCharacter(character.id.toString());
      
      if (success) {
        final index = characters.indexWhere((c) => c.id == character.id);
        if (index != -1) {
          characters[index] = characters[index].copyWith(isFavorite: false);
          notifyListeners();
        }
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAllFavorites() async {
    try {
      final success = await _favoritesRepo.clearFavorites();
      
      if (success) {
        for (int i = 0; i < characters.length; i++) {
          characters[i] = characters[i].copyWith(isFavorite: false);
        }
        notifyListeners();
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  void toggleLoading(bool hasMore) {
    this.hasMore = hasMore;
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (!_showOnlyFavorites) {
      await getCharactersList(_currentPage);
    }
  }

  Future<void> refreshList() async {
    _currentPage = 1;
    characters.clear();
    hasMore = true;
    errorMessage = '';
    
    if (_showOnlyFavorites) {
      await _updateFavoriteStatus();
    } else {
      await getCharactersList(1);
    }
  }

  Future<void> loadFavorites() async {
    if (characters.isEmpty) {
      await getCharactersList(1);
    } else {
      await _updateFavoriteStatus();
    }
  }
}