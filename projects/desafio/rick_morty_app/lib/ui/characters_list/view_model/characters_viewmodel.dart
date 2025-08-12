import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/character_repository.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepo;

  CharactersViewModel({
    required CharacterRepository characterRepo
  }) : _characterRepo = characterRepo;

  List<Character> characters = [];
  int _currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String errorMessage = '';

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
    toggleLoading(true);
  }

  void toggleLoading(bool hasMore) {
    this.hasMore = hasMore;
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    await getCharactersList(_currentPage + 1);
  }

  Future<void> refreshList() async {
    _currentPage = 1;
    characters.clear();
    hasMore = true;
    await getCharactersList(1);
  } 
}