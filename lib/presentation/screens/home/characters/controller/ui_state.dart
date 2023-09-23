// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharactersUiState {
  bool loading;
   bool loadingPagination;
  CharactersUiState({
    this.loading = false,
    this.loadingPagination = false,
  });

  CharactersUiState copyWith({
    bool? loading,
    bool? loadingPagination,
  }) {
    return CharactersUiState(
      loading: loading ?? this.loading,
      loadingPagination: loadingPagination ?? this.loadingPagination,
    );
  }
}
