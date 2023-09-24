// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod_course_preview/data/models/episode.dart';
import 'package:riverpod_course_preview/data/models/pagination.dart';


class EpisodesPagination {
  
  final Pagination info;
  final List<Episode> results;
  EpisodesPagination({
    required this.info,
    required this.results,
  });

  EpisodesPagination copyWith({
    Pagination? info,
    List<Episode>? results,
  }) {
    return EpisodesPagination(
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

  factory EpisodesPagination.fromMap(Map<String, dynamic> map) {
    return EpisodesPagination(
      info: Pagination.fromMap(map['info'] as Map<String, dynamic>),
      results: List<Episode>.from(
        (map['results']).map<Episode>(
          (x) => Episode.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodesPagination.fromJson(String source) =>
      EpisodesPagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CharactersPagination(info: $info, results: $results)';

}
