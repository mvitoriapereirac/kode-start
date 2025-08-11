import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

abstract class CharacterRepository implements ChangeNotifier {
  Future<Result<List<Character>>> getCharactersList(int? page);
  Future<bool> saveCache(Character char);
}