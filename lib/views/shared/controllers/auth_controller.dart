// ignore_for_file: public_member_api_docs, sort_constructors_first
//1. Definimos el estado

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/user.dart';
import 'package:riverpod_course_preview/views/shared/providers/repository_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repositoryService = ref.read(repositoryProvider);
  const authState = AuthState();
  final notifier =
      AuthNotifier(authState, repositoryProvider: repositoryService);

  return notifier;
});

class AuthState {
  final User? user;

  const AuthState({this.user});

  AuthState copyWith({
    User? user,
  }) {
    return AuthState(
      user: user ?? this.user,
    );
  }
}
//2. Definimos el notifier

class AuthNotifier extends StateNotifier<AuthState> {
  final RepositoryProvider repositoryProvider;
  AuthNotifier(super.state, {required this.repositoryProvider});

  Future<void> login(String username, String password) async {
    final user =
        await repositoryProvider.authRepository.login(username, password);
    state = state.copyWith(user: user);
  }
}
