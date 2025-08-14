import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/data/repositories/character_repository.dart';
import 'package:rick_morty_app/data/repositories/episode_repository.dart';
import 'package:rick_morty_app/data/repositories/favorites_repository.dart';
import 'package:rick_morty_app/data/services/api_service.dart';
import 'package:rick_morty_app/data/services/shared_preferences_service.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';
import 'package:rick_morty_app/domain/favorites_repository.dart';
import 'package:rick_morty_app/main.dart';

void injectDependencies() {
  runApp(
    MultiProvider(providers: [
      Provider<ApiService>(create: (context) => ApiService()),
      Provider<SharedPreferencesService>(create: (context) => SharedPreferencesService()),
       ChangeNotifierProvider(
          create: (context) => FavoritesRepo(
            sharedPreferencesService: context.read(),
          ) as FavoritesRepository,
        ),
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

