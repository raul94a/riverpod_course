// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod_course_preview/data/models/pagination.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';

class CharactersPagination {
  
  final Pagination info;
  final List<RickAndMortyCharacter> results;
  CharactersPagination({
    required this.info,
    required this.results,
  });

  CharactersPagination copyWith({
    Pagination? info,
    List<RickAndMortyCharacter>? results,
  }) {
    return CharactersPagination(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory CharactersPagination.fromMap(Map<String, dynamic> map) {
    return CharactersPagination(
      info: Pagination.fromMap(map['info'] as Map<String, dynamic>),
      results: List<RickAndMortyCharacter>.from(
        (map['results']).map<RickAndMortyCharacter>(
          (x) => RickAndMortyCharacter.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharactersPagination.fromJson(String source) =>
      CharactersPagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CharactersPagination(info: $info, results: $results)';

}
