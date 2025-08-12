import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/character_repository.dart';
import 'package:rick_morty_app/domain/episode_repository.dart';
import 'package:rick_morty_app/routing/route_paths.dart';
import 'package:rick_morty_app/ui/character_details/view_model/details_viewmodel.dart';
import 'package:rick_morty_app/ui/character_details/widgets/character_details_screen.dart';
import 'package:rick_morty_app/ui/characters_list/view_model/characters_viewmodel.dart';
import 'package:rick_morty_app/ui/characters_list/widgets/characters_list_screen.dart';
import 'package:provider/provider.dart';

GoRouter router(
  CharacterRepository characterRepo,
  EpisodeRepository episodeRepo
  ) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  refreshListenable: characterRepo as Listenable,
  routes: [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: CharactersListScreen(
            viewModel: CharactersViewModel(
              characterRepo: context.read(),
            )
          ),
        );
      }),
    GoRoute(
      path: Routes.details,
      pageBuilder: (context, state) {
        final character = state.extra as Character;
        return NoTransitionPage(
          child: CharacterDetailsScreen(
            viewModel: DetailsViewModel(
              episodeRepository: context.read(),
              character: character
              ),
          ),
        );
      }
    )
  ]
  );
