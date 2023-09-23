import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
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
    final characters = ref.watch(charactersProvider).characters;
    return ListView.builder(
        itemCount: characters.length,
        itemBuilder: (cntx, index) {
          return Container(
            height: 50,
            child: Text(characters[index].name));
        });
  }
}
