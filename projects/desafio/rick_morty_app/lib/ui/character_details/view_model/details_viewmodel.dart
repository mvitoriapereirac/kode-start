import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';

class DetailsViewModel extends ChangeNotifier {
  final EpisodeRepository _episodeRepo;
  final Character character;

  DetailsViewModel({
    required EpisodeRepository episodeRepository,
    required this.character
  }) : _episodeRepo = episodeRepository;

}