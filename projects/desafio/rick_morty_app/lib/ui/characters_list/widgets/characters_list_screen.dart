import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/routing/route_paths.dart';
import 'package:rick_morty_app/ui/characters_list/view_model/characters_viewmodel.dart';
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
        _scrollController.position.maxScrollExtent - 200) {
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
            color: const Color(0xFF1C1B1F), //Sensação de tab bar maior, porém mais parecido com os apps do mercado do que se estivesse na cor preta. Para checar o tamanho da tab bar, basta comentar essa linha
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: const AppBarComponent(),
                body: RefreshIndicator(
                color:const Color(0xFF87A1FA),
                backgroundColor: const Color(0xFF87A1FA).withAlpha(2),
                onRefresh: viewModel.refreshList,
                child: viewModel.characters.isEmpty && viewModel.errorMessage.isNotEmpty
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ErrorMessageComponent(viewModel.errorMessage)
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            viewModel.characters.length + (viewModel.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < viewModel.characters.length) {
                            final character = viewModel.characters[index];
                            return GestureDetector(
                              child: CharacterCard(
                                character: character,
                                isFirstCard: index == 0),
                              onTap: () => context.go(Routes.details, extra: character)
                            );
                          }
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(color: Color(0xFF87A1FA)),
                              ),
                            );
                        },
                      ),
                  ),
              ),
            ),
          );
        },
      ),
    );
  }
}
