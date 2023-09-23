import 'package:http/http.dart';
import 'package:riverpod_course_preview/data/models/characters_pagination.dart';

class CharactersRepository {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<CharactersPagination> getAll(String token, [String? url]) async {
    bool hasValue = url != null;
    final uri = Uri.parse(hasValue ? url : baseUrl);
    //HEADERS!!!!!!!!!
    //token!!!!!!!!!!!
    final headers = {'Authorization': 'Bearer $token'};
    final data = await get(uri, headers: headers);
    return CharactersPagination.fromJson(data.body);
  }
}
