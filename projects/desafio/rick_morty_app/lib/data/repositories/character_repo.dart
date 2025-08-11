import 'package:flutter/material.dart';
import 'package:rick_morty_app/data/services/api_service.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

class CharacterRepo extends ChangeNotifier implements CharacterRepository {
  CharacterRepo({required ApiService apiService})
          : _apiService = apiService;

  late final ApiService _apiService;
  @override
  Future<Result<List<Character>>> getCharactersList(int? page) async {
    var path = 'character';
    if (page != null) {
      path = '$path/?page=$page';
    }
    try {
      final response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
      final results = response.data['results'];
        final characterList = (results as List).map((e) => Character.fromMap(e)).cast<Character>().toList();
        return Result<List<Character>>(data: characterList);
      }
      return Result<List<Character>>(error: response.statusMessage);
    } on Exception catch (e) {
      return Result<List<Character>>(error: e.toString());
    }
  }

  @override
  Future<bool> saveCache(Character char) {
    // TODO: implement saveCache
    throw UnimplementedError();
  }

  
}