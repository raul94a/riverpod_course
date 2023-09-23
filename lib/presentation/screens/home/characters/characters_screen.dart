import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/widgets/character_card.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  bool canFetch = true;
  @override
  void initState() {
    super.initState();
    final notifier = ref.read(charactersProvider.notifier);
    final count = ref.read(charactersProvider).characters.length;
    if (count == 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifier.getAll();
      });
    }

    scrollController.addListener(() async {
      final position = scrollController.position;
      final maxExtent = position.maxScrollExtent;
      final currentPosition = scrollController.offset;
      const sensibility = 0.29;
      final shouldFetchNewPage = currentPosition >= maxExtent * sensibility;
      if (shouldFetchNewPage && canFetch) {
        try {
          canFetch = false;
          await notifier.getAll();
        } catch (err) {
          print(err);
        } finally {
          canFetch = true;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final characters = ref.watch(charactersProvider).characters;
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: characters.length,
                  restorationId: 'restorationChars',
                  itemBuilder: (cntx, index) {
                    final character = characters[index];

                    return CharacterCard(
                      character: character,
                      position: index,
                    );
                  }),
            ),
            // mostrar el spinner
            const _LoadingPaginationSpinner()
          ],
        ),
        const _LoadingStatus()
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _LoadingPaginationSpinner extends ConsumerWidget {
  const _LoadingPaginationSpinner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(
        charactersProvider.select((value) => value.uiState.loadingPagination));
    if (loading) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: CircularProgressIndicator(
            color: lightColorScheme.primary,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
    
  }
}

class _LoadingStatus extends ConsumerWidget {
  const _LoadingStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading =
        ref.watch(charactersProvider.select((value) => value.uiState.loading));
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          color: lightColorScheme.primary,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
