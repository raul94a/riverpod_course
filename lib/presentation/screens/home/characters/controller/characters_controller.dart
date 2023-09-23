// ignore_for_file: public_member_api_docs, sort_constructors_first
// 3 provider

// 1 estado
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/ui_state.dart';
import 'package:riverpod_course_preview/presentation/shared/controllers/auth_controller.dart';
import 'package:riverpod_course_preview/presentation/shared/providers/repository_provider.dart';

final charactersProvider =
    StateNotifierProvider<CharactersNotifier, CharactersState>((ref) {
  final repositoryService = ref.read(repositoryProvider);
  final token =
      ref.watch(authProvider.select((value) => value.user?.token ?? ''));
  final characterState = CharactersState(
      characters: [], uiState: CharactersUiState(), token: token);

  return CharactersNotifier(characterState, repositoryService);
});

class CharactersState {
  final List<RickAndMortyCharacter> characters;
  final CharactersUiState uiState;
  final String token;
  final String? nextPageUrl;
  CharactersState(
      {required this.characters,
      required this.uiState,
      required this.token,
      this.nextPageUrl});

  CharactersState copyWith(
      {List<RickAndMortyCharacter>? characters,
      CharactersUiState? uiState,
      String? token,
      String? nextPageUrl}) {
    return CharactersState(
      characters: characters ?? this.characters,
      uiState: uiState ?? this.uiState,
      token: token ?? this.token,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }

  CharactersState copyWithNextPageUrl(
      {List<RickAndMortyCharacter>? characters,
      CharactersUiState? uiState,
      String? token,
      String? nextPageUrl}) {
    return CharactersState(
      characters: characters ?? this.characters,
      uiState: uiState ?? this.uiState,
      token: token ?? this.token,
      nextPageUrl: nextPageUrl,
    );
  }
}

class CharactersNotifier extends StateNotifier<CharactersState> {
  final RepositoryProvider repositoryService;

  CharactersNotifier(super.state, this.repositoryService);

  Future<void> getAll() async {
    final url = state.nextPageUrl;
    final charactersPagination =
        await repositoryService.charactersRepository.getAll(state.token, url);
    final characters = charactersPagination.results;
    state.characters.addAll(characters);

    state = state.copyWithNextPageUrl(
        characters: [...state.characters],
        nextPageUrl: charactersPagination.info.next);
  }

  void delete(int position) {
    final characters = state.characters;
    characters.removeAt(position);

    state = state.copyWith(characters: [...characters]);
  }
}
