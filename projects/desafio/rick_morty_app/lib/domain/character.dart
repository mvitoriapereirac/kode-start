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
  final List<Episode> appearedAt;

  Character(this._id, {required this.name, required this.imageUrl, required this.species, required this.gender, required this.status, required this.lastKnownLocation, required this.appearedAt, this.isFavorite = false});

  int get id => _id;
  bool isFavorite; // Adicione esta propriedade


  static fromMap(Map<String, dynamic> map) {
    return Character(
      map['id'],
      name: map['name'],
      imageUrl: map['image'],
      species: map['species'],
      gender: Gender.fromString(map['gender']),
      status: Status.fromString(map['status']),
      lastKnownLocation: Location.fromMap(map['location']),
      appearedAt: (map['episode'] as List)
          .map<Episode>((e) => Episode(url: e))
          .toList(),
   );
  }

  Character copyWith({
    int? id,
    String? name,
    String? imageUrl,
    bool? isFavorite,
    String? species,
    Gender? gender,
    Status? status,
    Location? lastKnownLocation,
    List<Episode>? appearedAt
  }) {
    return Character(
      id ?? _id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite, 
      species: species ?? this.species,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      appearedAt: appearedAt ?? this.appearedAt
    );
  }
}
