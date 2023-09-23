// ignore_for_file: public_member_api_docs, sort_constructors_first
// 3 provider

// 1 estado
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/pagination.dart';
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
  final String status;
  final Pagination? currentPagination;
  CharactersState({
    required this.characters,
    required this.uiState,
    this.status = 'All',
    this.currentPagination,
    required this.token,
  });

  CharactersState copyWith({
    List<RickAndMortyCharacter>? characters,
    CharactersUiState? uiState,
    Pagination? currentPagination,
    String? token,
    String? status,
  }) {
    return CharactersState(
      currentPagination: currentPagination ?? this.currentPagination,
      characters: characters ?? this.characters,
      uiState: uiState ?? this.uiState,
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  List<RickAndMortyCharacter> getFilteredCharacters() {
    if (status == 'All') {
      return characters;
    }
    return characters.where((char) => char.status == status).toList();
  }
}

class CharactersNotifier extends StateNotifier<CharactersState> {
  final RepositoryProvider repositoryService;

  CharactersNotifier(super.state, this.repositoryService);

  void _changeLoadingStatus(bool loading) {
    CharactersUiState uiState = state.uiState;
    uiState.loading = loading;
    state = state.copyWith(uiState: uiState);
  }

  void _changeLoadingStatusPagination(bool loading) {
    CharactersUiState uiState = state.uiState;
    uiState.loadingPagination = loading;
    state = state.copyWith(uiState: uiState);
  }

  void changeFilterStatus(String value) {
    state = state.copyWith(status: value);
  }

  Future<void> getAll() async {
    final url = state.currentPagination?.next;
    if (state.characters.isNotEmpty && url == null) {
      return;
    }
    url == null
        ? _changeLoadingStatus(true)
        : _changeLoadingStatusPagination(true);
    try {
      final charactersPagination =
          await repositoryService.charactersRepository.getAll(state.token, url);
      final characters = charactersPagination.results;
      state.characters.addAll(characters);

      state = state.copyWith(
          characters: [...state.characters],
          currentPagination: charactersPagination.info);
    } catch (err) {
      print(err);
    } finally {
      url == null
          ? _changeLoadingStatus(false)
          : _changeLoadingStatusPagination(false);
    }
  }

  Future<void> search(String str) async {
    state = state.copyWith(characters: []);
    _changeLoadingStatus(true);
    try {
      final charactersPagination = await repositoryService.charactersRepository
          .searchByName(state.token, str);
      final characters = charactersPagination.results;
      state.characters.addAll(characters);

      state = state.copyWith(
          characters: [...state.characters],
          currentPagination: charactersPagination.info);
    } catch (error) {
      print(error);
    } finally {
      _changeLoadingStatus(false);
    }
  }

  void delete(int position) {
    final characters = state.characters;
    characters.removeAt(position);
    print('Removing psoition: $position');

    state = state.copyWith(characters: [...characters]);
  }
}
