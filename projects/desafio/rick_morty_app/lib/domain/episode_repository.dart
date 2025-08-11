import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/episode.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

abstract class EpisodeRepository implements ChangeNotifier {
  Future<Result<Episode>> getEpisode(String id);
}