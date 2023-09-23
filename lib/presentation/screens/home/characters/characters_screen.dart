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
  @override
  void initState() {
    super.initState();
    final count = ref.read(charactersProvider).characters.length;
    if (count == 0) {
      ref.read(charactersProvider.notifier).getAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final characters = ref.watch(charactersProvider).characters;
    return ListView.builder(
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
