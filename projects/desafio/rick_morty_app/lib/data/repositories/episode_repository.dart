import 'dart:convert';
import 'package:rick_morty_app/data/services/api_service.dart';
import 'package:rick_morty_app/domain/episode.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';
import 'package:rick_morty_app/domain/utils/result.dart';

class EpisodeRepo extends EpisodeRepository {
  final apiService = ApiService();

  @override
  Future<Result<Episode>> getEpisode(String id) async {
    final response = await apiService.getRequest('episode/$id');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      final episode = Episode.fromMap(data);
      return Result<Episode>(data: episode);
    }
    return Result(error: response.statusMessage);
  }

}