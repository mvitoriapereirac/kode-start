import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';

// class DetailsViewModel extends ChangeNotifier {
//   

class DetailsViewModel extends ChangeNotifier {
  final EpisodeRepository _episodeRepo;
  Character character;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DetailsViewModel({
    required EpisodeRepository episodeRepository,
    required this.character
  }) : _episodeRepo = episodeRepository {
    getEpisode();
  }

  String errorMessage = 'lorem ipsum';

  Future<void> getEpisode() async {
    _isLoading = true;
    errorMessage = '';
    notifyListeners();

    final response = await _episodeRepo.getEpisode(character.appearedAt[0].getId().toString());

    _isLoading = false;

    if (response.error != null) {
      errorMessage = response.error!;
      notifyListeners();
      return;
    }

    if (response.data == null || response.data?.name == null) {
      errorMessage = 'Nenhum episódio encontrado';
      notifyListeners();
      return;
    }

    final episode = response.data;
    character.appearedAt[0].name = episode!.name;
    notifyListeners();
  }
}