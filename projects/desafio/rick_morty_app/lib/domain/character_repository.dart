import 'package:rick_morty_app/domain/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharactersList();
  Future<bool> saveCache(Character char);
}