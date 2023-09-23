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
  CharactersState({
    required this.characters,
    required this.uiState,
    required this.token,
  });

  CharactersState copyWith({
    List<RickAndMortyCharacter>? characters,
    CharactersUiState? uiState,
    String? token,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      uiState: uiState ?? this.uiState,
      token: token ?? this.token,
    );
  }
}

class CharactersNotifier extends StateNotifier<CharactersState> {
  final RepositoryProvider repositoryService;

  CharactersNotifier(super.state, this.repositoryService);

  Future<void> getAll([String? url]) async {
    final charactersPagination =
        await repositoryService.charactersRepository.getAll(state.token, url);
    final characters = charactersPagination.results;
    state.characters.addAll(characters);
    state = state.copyWith(characters: [...characters]);
  }
}
