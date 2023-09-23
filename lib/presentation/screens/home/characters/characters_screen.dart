import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/widgets/character_card.dart';

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
      notifier.getAll();
    }

    scrollController.addListener(() async {
      final position = scrollController.position;
      final maxExtent = position.maxScrollExtent;
      final currentPosition = scrollController.offset;
      const sensibility = 0.85;
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
    return ListView.builder(
        controller: scrollController,
        itemCount: characters.length,
        restorationId: 'restorationChars',
        itemBuilder: (cntx, index) {
          final character = characters[index];

          return CharacterCard(character: character);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
