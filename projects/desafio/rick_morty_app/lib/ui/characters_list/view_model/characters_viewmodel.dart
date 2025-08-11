import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character_repository.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepo;

  CharactersViewModel({
    required CharacterRepository characterRepo
  }) : _characterRepo = characterRepo;
  
}