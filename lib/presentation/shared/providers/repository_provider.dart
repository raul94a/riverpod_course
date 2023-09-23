import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/api/auth_api.dart';
import 'package:riverpod_course_preview/data/repositories/auth_repository.dart';
import 'package:riverpod_course_preview/data/repositories/characters_repository.dart';
import 'package:riverpod_course_preview/presentation/shared/providers/environment_provider.dart';

final repositoryProvider = Provider((ref) {
  // no tener en cuenta el environment para el curso hasta el final
  final environment = ref.read(environmentProvider);
  // no tener en cuentaeste print
  print(environment.baseUrl);
  final authRepository = AuthRepository(AuthApi());
  final characterRepository = CharactersRepository();
  final repositoryProvider = RepositoryProvider(
      authRepository: authRepository,
      charactersRepository: characterRepository);
  return repositoryProvider;
});

class RepositoryProvider {
  final AuthRepository authRepository;
  final CharactersRepository charactersRepository;
  const RepositoryProvider(
      {required this.authRepository, required this.charactersRepository});
}
