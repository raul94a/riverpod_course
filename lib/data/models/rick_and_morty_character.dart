// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class RickAndMortyCharacter {
    final int id;
    final String name;
    final String type;
    final String dimension;
    final List<String> residents;
    final String url;
    final DateTime created;
  RickAndMortyCharacter({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  

  RickAndMortyCharacter copyWith({
    int? id,
    String? name,
    String? type,
    String? dimension,
    List<String>? residents,
    String? url,
    DateTime? created,
  }) {
    return RickAndMortyCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
      residents: residents ?? this.residents,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
      'residents': residents,
      'url': url,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory RickAndMortyCharacter.fromMap(Map<String, dynamic> map) {
    return RickAndMortyCharacter(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      dimension: map['dimension'] as String,
      residents: List<String>.from((map['residents'] as List<String>)),
      url: map['url'] as String,
      created: DateTime.parse(map['created'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RickAndMortyCharacter.fromJson(String source) => RickAndMortyCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RickAndMortyChar4acter(id: $id, name: $name, type: $type, dimension: $dimension, residents: $residents, url: $url, created: $created)';
  }

}
