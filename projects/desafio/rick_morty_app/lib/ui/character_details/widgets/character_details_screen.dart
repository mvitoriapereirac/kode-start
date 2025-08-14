import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/routing/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/ui/character_details/view_model/details_viewmodel.dart';
import 'package:rick_morty_app/ui/character_details/widgets/related_characters_collection.dart';
import 'package:rick_morty_app/ui/core/ui/app_bar_component.dart';
import 'package:rick_morty_app/ui/core/ui/character_card.dart';
import 'package:rick_morty_app/ui/core/ui/error_message_component.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final DetailsViewModel viewModel;

  const CharacterDetailsScreen({
    super.key,
    required this.viewModel
  }); 

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DetailsViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: const Color(0xFF1C1B1F),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBarComponent(returnToList: () => context.go(Routes.home)),
                body: _buildBody(viewModel)
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(DetailsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF87A1FA),
        ),
      );
    }

    if (viewModel.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ErrorMessageComponent(viewModel.errorMessage),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterCard(
          character: viewModel.character,
          isFirstCard: true,
          isDetailsView: true
        ),
        const Spacer(),
        if (viewModel.relatedCharacters != null)...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Personagens relacionados', style: GoogleFonts.lato(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          )
        ),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RelatedCharactersCollectionScreen(relatedCharacters: viewModel.relatedCharacters!, loadedCharacters: viewModel.loadedCharacters),
        )
        ]
      ],
    );
  }
}