import 'package:http/http.dart';
import 'package:riverpod_course_preview/data/models/characters_pagination.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';

class CharactersRepository {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<CharactersPagination> getAll(String token, [String? url]) async {
    bool hasValue = url != null;
    final uri = Uri.parse(hasValue ? url : '$baseUrl/character');
    //HEADERS!!!!!!!!!
    //token!!!!!!!!!!!
    final headers = {'Authorization': 'Bearer $token'};
    final data = await get(uri, headers: headers);
    ;
    return CharactersPagination.fromJson(data.body);
  }

  Future<CharactersPagination> searchByName(String token, String str,
      [String? url]) async {
    bool hasValue = url != null;
    final uri = Uri.parse(hasValue ? url : '$baseUrl/character?name=$str');
    //HEADERS!!!!!!!!!
    //token!!!!!!!!!!!
    final headers = {'Authorization': 'Bearer $token'};
    final data = await get(uri, headers: headers);
    
    return CharactersPagination.fromJson(data.body);
  }

  Future<RickAndMortyCharacter> getOne(String token, String url) async {
    final uri = Uri.parse(url);
    final response =
        await get(uri, headers: {'Authorization': 'Bearer $token'});
    return RickAndMortyCharacter.fromJson(response.body);
  }
}
