import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/routing/route_paths.dart';
import 'package:rick_morty_app/ui/characters_list/view_model/characters_viewmodel.dart';
import 'package:rick_morty_app/ui/characters_list/widgets/custom_tab_switch.dart';
import 'package:rick_morty_app/ui/core/ui/app_bar_component.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/ui/core/ui/character_card.dart';
import 'package:rick_morty_app/ui/core/ui/error_message_component.dart';

class CharactersListScreen extends StatefulWidget {
  final CharactersViewModel viewModel;

  const CharactersListScreen({super.key, required this.viewModel});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Carrega a primeira página da API ao abrir
    widget.viewModel.getCharactersList(1);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      widget.viewModel.loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<CharactersViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: const Color(0xFF1C1B1F),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: const AppBarComponent(),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomTabSwitch(
                        showOnlyFavorites: viewModel.showOnlyFavorites,
                        onToggle: (showFavorites) {
                          viewModel.toggleFavoritesFilter();
                        },
                      ),
                    ),
                    
                    Expanded(
                      child: RefreshIndicator(
                        color: const Color(0xFF87A1FA),
                        backgroundColor: const Color(0xFF87A1FA).withAlpha(2),
                        onRefresh: viewModel.refreshList,
                        child: _buildCharactersList(viewModel),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

Widget _buildCharactersList(CharactersViewModel viewModel) {
  // Use a lista filtrada
  final charactersToShow = viewModel.filteredCharacters;
  
  if (charactersToShow.isEmpty && viewModel.errorMessage.isNotEmpty) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ErrorMessageComponent(viewModel.errorMessage),
    );
  }
  
  if (viewModel.filteredCharacters.isEmpty && viewModel.showOnlyFavorites) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 64,
                color: Colors.grey[600],
              ),
              SizedBox(height: 16),
              Text(
                'Sem favoritos ainda',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pressione o ícone de coração para adicionar personagens aos favoritos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  return ListView.builder(
    controller: _scrollController,
    itemCount: viewModel.filteredCharacters.length + (!viewModel.showOnlyFavorites && viewModel.hasMore ? 1 : 0),
    itemBuilder: (context, index) {
      if (index < viewModel.filteredCharacters.length) {
        var character = viewModel.filteredCharacters[index];
        return GestureDetector(
          child: CharacterCard(
            character: character,
            isFirstCard: index == 0,
            onFavoriteToggle: () => viewModel.toggleFavorite(character),
          ),
          onTap: () {
            context.go(Routes.details, extra: (
              character: character, 
              loaded: viewModel.characters
            ));
          },
        );
      }
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF87A1FA)),
        ),
      );
    },
  );
  }
}