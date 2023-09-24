// ignore_for_file: public_member_api_docs, sort_constructors_first
class EpisodeUiState {
  bool loading;
   bool loadingPagination;
  EpisodeUiState({
    this.loading = false,
    this.loadingPagination = false,
  });

  EpisodeUiState copyWith({
    bool? loading,
    bool? loadingPagination,
  }) {
    return EpisodeUiState(
      loading: loading ?? this.loading,
      loadingPagination: loadingPagination ?? this.loadingPagination,
    );
  }
}
