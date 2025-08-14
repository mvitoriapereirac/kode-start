import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

abstract class CharacterRepository implements ChangeNotifier {
  Future<Result<List<Character>>> getCharactersList(int? page);
  List<Character> getRelatedCharacters(Character target, List<Character> loadedCharacters, {double minSimilarity = 0.2});
}