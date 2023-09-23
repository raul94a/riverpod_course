import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';

class CharacterDescriptionScreen extends ConsumerWidget {
  const CharacterDescriptionScreen({super.key, required this.character});
  final RickAndMortyCharacter character;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Hero(
                tag: 'Hero-Character-${character.id}',
                child: Image.network(
                  character.image,
           
                  fit: BoxFit.fitWidth,
                ))
          ],
        ),
      ),
    );
  }
}
