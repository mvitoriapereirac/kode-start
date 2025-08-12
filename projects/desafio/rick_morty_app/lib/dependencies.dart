import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/data/repositories/character_repo.dart';
import 'package:rick_morty_app/data/repositories/episode_repository.dart';
import 'package:rick_morty_app/data/services/api_service.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';
import 'package:rick_morty_app/main.dart';

void injectDependencies() {
  runApp(
    MultiProvider(providers: [
      Provider<ApiService>(create: (context) => ApiService()),
      ChangeNotifierProvider(
        create: (context) => CharacterRepo(
          apiService: context.read(),
        ) as CharacterRepository,
      ),
      ChangeNotifierProvider(
        create: (context) => EpisodeRepo(
          apiService: context.read(),
        ) as EpisodeRepository,
      ),
    ],
    child: const MainApp(),
    )
  );
}

