import 'package:rick_morty_app/domain/enums/character_status_enum.dart';
import 'package:rick_morty_app/domain/enums/gender_enum.dart';
import 'package:rick_morty_app/domain/episode.dart';
import 'package:rick_morty_app/domain/location.dart';

class Character {
  final int _id;
  final String name;
  final String imageUrl;
  final Status status;
  final String species;
  final Gender gender;
  final Location lastKnownLocation;
  final List<Episode> firstAppearedAt;

  Character(this._id, {required this.name, required this.imageUrl, required this.species, required this.gender, required this.status, required this.lastKnownLocation, required this.firstAppearedAt});

  int get id => _id;

  static fromMap(Map<String, dynamic> map) {
    return Character(
      map['id'],
      name: map['name'],
      imageUrl: map['image'],
      species: map['species'],
      gender: Gender.fromString(map['gender']),
      status: Status.fromString(map['status']),
      lastKnownLocation: Location.fromMap(map['location']),
      firstAppearedAt: (map['episode'] as List)
          .map<Episode>((e) => Episode.fromMap(e))
          .toList(),
   );
  }
}
