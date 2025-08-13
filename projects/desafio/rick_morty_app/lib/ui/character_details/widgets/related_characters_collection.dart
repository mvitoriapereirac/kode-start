import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/routing/route_paths.dart';

class RelatedCharactersCollectionScreen extends StatelessWidget {
  final List<Character> relatedCharacters;
  final List<Character> loadedCharacters;

  const RelatedCharactersCollectionScreen({
    super.key,
    required this.relatedCharacters,
    required this.loadedCharacters
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // altura fixa para o "carrossel"
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: relatedCharacters.length,
        itemBuilder: (context, index) {
          final character = relatedCharacters[index];
          return GestureDetector(
            onTap: () {
              context.go(Routes.details, extra: (character: character, loaded: loadedCharacters));
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // círculo
                    child: Image.network(
                      character.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    character.name,
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
