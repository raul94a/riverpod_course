import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';

class CharacterDescriptionScreen extends ConsumerWidget {
  const CharacterDescriptionScreen(
      {super.key, this.tag, required this.character});
  final RickAndMortyCharacter character;
  final String? tag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: tag ?? 'Hero-Character-${character.id}',
                  child: Image.network(
                    character.image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Consumer(builder: (context, ref, _) {
                      final name = ref.watch(charactersProvider.select(
                          (value) =>
                              value.getCharacterById(character.id).name));
                      return Text(
                        name,
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
                      );
                    }),
                    TextFormField(
                      initialValue: character.name,
                      onChanged: (value) {
                        ref
                            .read(charactersProvider.notifier)
                            .changeCharacterName(character.id, value);
                      },
                    ),
                    TextFormField(
                      initialValue: character.location.name,
                      onChanged: (value) {
                        ref
                            .read(charactersProvider.notifier)
                            .changeCharacterLocation(character.id, value);
                      },
                    ),
                    DropdownButtonFormField<String>(
                        isExpanded: true,
                        style: const TextStyle(color: Colors.black),
                        value: character.status,
                        items: ['Alive', 'Dead', 'unknown']
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          ref
                              .read(charactersProvider.notifier)
                              .changeCharacterLifeStatus(
                                  character.id, value ?? character.status);
                        }),
                    ElevatedButton(
                      onPressed: Navigator.of(context).pop,
                      child: Text('Exit'),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.resolveWith(
                              (states) => Size(
                                  MediaQuery.of(context).size.width * 0.99,
                                  40))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
