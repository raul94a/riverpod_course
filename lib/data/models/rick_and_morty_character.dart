// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum LifeStatus {
  alive('Alive'),
  dead('Dead'),
  unknown('Unknown');

  final String name;
  const LifeStatus(this.name);
}


class RickAndMortyCharacter {
    final int id;
    final String name;
    final String status;
    final String species;
    final String type;
    final String gender;
    final CharacterLocation origin;
    final CharacterLocation location;
    final String image;
    final List<String> episode;
    final String url;
    final DateTime created;
  RickAndMortyCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  

  RickAndMortyCharacter copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    CharacterLocation? origin,
    CharacterLocation? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) {
    return RickAndMortyCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toMap(),
      'location': location.toMap(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory RickAndMortyCharacter.fromMap(Map<String, dynamic> map) {
    return RickAndMortyCharacter(
      id: map['id'] as int,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      type: map['type'] ?? '',
      gender: map['gender'] ?? '',
      origin: CharacterLocation.fromMap(map['origin'] as Map<String,dynamic>),
      location: CharacterLocation.fromMap(map['location'] as Map<String,dynamic>),
      image: map['image'] as String,
      episode: map['episode'] == null ? [] : List<String>.from((map['episode'] as List<dynamic>)),
      url: map['url'],
      created: DateTime.parse(map['created']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RickAndMortyCharacter.fromJson(String source) => RickAndMortyCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RickAndMortyCharacter(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }

}

class CharacterLocation {
    final String name;
    final String url;

    CharacterLocation({
        required this.name,
        required this.url,
    });

   

  CharacterLocation copyWith({
    String? name,
    String? url,
  }) {
    return CharacterLocation(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory CharacterLocation.fromMap(Map<String, dynamic> map) {
    return CharacterLocation(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterLocation.fromJson(String source) => CharacterLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CharacterLocation(name: $name, url: $url)';

  @override
  bool operator ==(covariant CharacterLocation other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

