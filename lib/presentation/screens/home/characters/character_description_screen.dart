import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';

class CharacterDescriptionScreen extends ConsumerWidget {
  const CharacterDescriptionScreen(
      {super.key, this.tag, required this.character});
  final RickAndMortyCharacter character;
  final String? tag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('count: ${character.episode.length}');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
                tag: tag ?? 'Hero-Character-${character.id}',
                child: Image.network(
                  character.image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      character.name,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 32,
                          color: Color.fromARGB(255, 41, 55, 127),
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(218, 46, 162, 58),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 20.2,
                            )
                          ],
                          fontWeight: FontWeight.bold,
                          fontFeatures: [FontFeature(AutofillHints.name)],
                          fontStyle: FontStyle.italic),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: character.episode.length,
                          itemBuilder: (ctx, i) {
                            final episode = character.episode[i];

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 1.5),
                              child: Text(episode),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
