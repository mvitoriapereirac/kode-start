import 'package:rick_morty_app/domain/episode.dart';

abstract class EpisodeRepository {
  Future<Episode> getEpisode(String url);
}