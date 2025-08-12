import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/domain/enums/character_status_enum.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool? isFirstCard;
  final bool? isDetailsView;

  const CharacterCard({
    super.key,
    required this.character,
    this.isFirstCard,
    this.isDetailsView
  });
    final _firstCardInsets = const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 7.50);
    final _insets = const EdgeInsets.symmetric(horizontal: 20, vertical: 7.50);
    final _borderRadiusDetailsScreen = const BorderRadius.all(Radius.circular(10));
    final _borderRadiusListScreen = const BorderRadius.only(
     topLeft: Radius.circular(10),
     topRight: Radius.circular(10),
    );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isFirstCard != null && isFirstCard == true ? _firstCardInsets : _insets,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: isDetailsView != null && isDetailsView == true ? 383 : 160,
          decoration: BoxDecoration(
            color: const Color(0xFF87A1FA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: isDetailsView != null && isDetailsView == true ? _borderRadiusDetailsScreen : _borderRadiusListScreen,
                child: Image.network(
                  character.imageUrl,
                  height: isDetailsView != null && isDetailsView == true ? 160 : 120,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 11, bottom: 12),
                child: SizedBox(
                  height: 17,
                  child: Text(
                    character.name.toUpperCase(),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.5,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              if (isDetailsView != null && isDetailsView == true)...[
              Padding(
                padding: const EdgeInsets.only(top: 38, left: 16),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: character.status == Status.dead ? Colors.red : Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    SizedBox(
                      height: 15,
                      child: Text(
                        '${character.status.value} - ${character.species}',
                        style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                        letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 15,
                    child: Text(
                      'Last known location:',
                      style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.5,
                      letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 15,
                    child: Text(
                      character.lastKnownLocation.name,
                      style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                      letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 15,
                    child: Text(
                      'First seen in:',
                      style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.5,
                      letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 15,
                    child: Text(
                      character.appearedAt[0].name,
                      style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                      letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
