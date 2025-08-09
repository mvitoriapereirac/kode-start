import 'dart:convert';
import 'package:rick_morty_app/data/services/api_service.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

class CharacterRepo extends CharacterRepository {
  final apiService = ApiService();

  @override
  Future<Result<List<Character>>> getCharactersList() async {
    final response = await apiService.getRequest('character');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      final characterList = (data as List).map((e) => Character.fromMap(e)).cast<Character>().toList();
      return Result<List<Character>>(data: characterList);
    }
    return Result<List<Character>>(error: response.statusMessage);
  }

  @override
  Future<bool> saveCache(Character char) {
    // TODO: implement saveCache
    throw UnimplementedError();
  }

  
}