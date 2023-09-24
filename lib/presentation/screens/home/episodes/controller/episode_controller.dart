// ignore_for_file: public_member_api_docs, sort_constructors_first
// 3 provider

// 1 estado
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/episode.dart';
import 'package:riverpod_course_preview/data/models/pagination.dart';
import 'package:riverpod_course_preview/presentation/screens/home/episodes/controller/ui_state.dart';
import 'package:riverpod_course_preview/presentation/shared/controllers/auth_controller.dart';
import 'package:riverpod_course_preview/presentation/shared/providers/repository_provider.dart';

final episodesProvider =
    StateNotifierProvider<EpisodesNotifier, EpisodesState>((ref) {
  final repositoryService = ref.read(repositoryProvider);
  final token =
      ref.watch(authProvider.select((value) => value.user?.token ?? ''));
  final episodestate = EpisodesState(
      episodes: [], uiState: EpisodeUiState(), token: token);

  return EpisodesNotifier(episodestate, repositoryService);
});

class EpisodesState {
  final List<Episode> episodes;
  final EpisodeUiState uiState;
  final String token;
  final String status;
  final Pagination? currentPagination;
  EpisodesState({
    required this.episodes,
    required this.uiState,
    this.status = 'All',
    this.currentPagination,
    required this.token,
  });

  EpisodesState copyWith({
    List<Episode>? episodes,
    EpisodeUiState? uiState,
    Pagination? currentPagination,
    String? token,
    String? status,
  }) {
    return EpisodesState(
      currentPagination: currentPagination ?? this.currentPagination,
      episodes: episodes ?? this.episodes,
      uiState: uiState ?? this.uiState,
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  
}

class EpisodesNotifier extends StateNotifier<EpisodesState> {
  final RepositoryProvider repositoryService;

  EpisodesNotifier(super.state, this.repositoryService);

  void _changeLoadingStatus(bool loading) {
    EpisodeUiState uiState = state.uiState;
    uiState.loading = loading;
    state = state.copyWith(uiState: uiState);
  }

  void _changeLoadingStatusPagination(bool loading) {
    EpisodeUiState uiState = state.uiState;
    uiState.loadingPagination = loading;
    state = state.copyWith(uiState: uiState);
  }

  void changeFilterStatus(String value) {
    state = state.copyWith(status: value);
  }

  Future<void> getAll() async {
    final url = state.currentPagination?.next;
    if (state.episodes.isNotEmpty && url == null) {
      return;
    }
    url == null
        ? _changeLoadingStatus(true)
        : _changeLoadingStatusPagination(true);
    try {
      final episodesPagination =
          await repositoryService.episodesRepository.getAll(state.token, url);
      final episodes = episodesPagination.results;
      state.episodes.addAll(episodes);

      state = state.copyWith(
          episodes: [...state.episodes],
          currentPagination: episodesPagination.info);
    } catch (err) {
      print(err);
    } finally {
      url == null
          ? _changeLoadingStatus(false)
          : _changeLoadingStatusPagination(false);
    }
  }

  Future<void> search(String str) async {
    state = state.copyWith(episodes: []);
    _changeLoadingStatus(true);
    try {
      final episodesPagination = await repositoryService.episodesRepository
          .searchByName(state.token, str);
      final episodes = episodesPagination.results;
      state.episodes.addAll(episodes);

      state = state.copyWith(
          episodes: [...state.episodes],
          currentPagination: episodesPagination.info);
    } catch (error) {
      print(error);
    } finally {
      _changeLoadingStatus(false);
    }
  }

  void delete(int position) {
    final episodes = state.episodes;
    episodes.removeAt(position);
    print('Removing psoition: $position');

    state = state.copyWith(episodes: [...episodes]);
  }
}
