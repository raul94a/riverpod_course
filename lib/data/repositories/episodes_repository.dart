import 'package:http/http.dart';
import 'package:riverpod_course_preview/data/models/episodes_pagination.dart';

class EpisodesRepository {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<EpisodesPagination> getAll(String token, [String? url]) async {
    bool hasValue = url != null;
    final uri = Uri.parse(hasValue ? url : '$baseUrl/episode');
    //HEADERS!!!!!!!!!
    //token!!!!!!!!!!!
    final headers = {'Authorization': 'Bearer $token'};
    final data = await get(uri, headers: headers);
  
    return EpisodesPagination.fromJson(data.body);
  }

  Future<EpisodesPagination> searchByName(String token, String str,[String? url]) async {
    bool hasValue = url != null;
    final uri = Uri.parse(hasValue ? url : '$baseUrl/episode?name=$str');
    //HEADERS!!!!!!!!!
    //token!!!!!!!!!!!
    final headers = {'Authorization': 'Bearer $token'};
    final data = await get(uri, headers: headers);;
    return EpisodesPagination.fromJson(data.body);
  }
}
