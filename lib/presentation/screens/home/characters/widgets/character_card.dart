import 'package:flutter/material.dart';
import 'package:riverpod_course_preview/data/models/rick_and_morty_character.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

final onPrimaryContainerColor = lightColorScheme.onPrimaryContainer;

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: lightColorScheme.primaryContainer,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: lightColorScheme.primaryContainer)),
        key: Key('char:${character.id}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardImage(character: character),
            const SizedBox(
              width: 10,
            ),
            _CharacterInformation(character: character)
          ],
        ));
  }
}

class _CharacterInformation extends StatelessWidget {
  const _CharacterInformation({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  (String, Color) getStatus(String status) {
    if (status == LifeStatus.alive.name) {
      return (LifeStatus.alive.name, Colors.greenAccent);
    } else if (status == LifeStatus.dead.name) {
      return (LifeStatus.dead.name, Colors.redAccent);
    }
    return (LifeStatus.unknown.name, Colors.yellowAccent);
  }

  @override
  Widget build(BuildContext context) {
    var (status, color) = getStatus(character.status);

    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CharacterName(character: character),
        _AliveStatus(color: color, status: status),
        _LastKnownLocation(character: character),
        _FirstAppearance(character: character),
      ],
    ));
  }
}

class _CharacterName extends StatelessWidget {
  const _CharacterName({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Text(character.name,
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: onPrimaryContainerColor)),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

class _LastKnownLocation extends StatelessWidget {
  const _LastKnownLocation({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  @override
  Widget build(BuildContext context) {
    return Column(      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          'Last known location',
          style: TextStyle(fontSize: 14, color: onPrimaryContainerColor),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          character.location.name,  overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: onPrimaryContainerColor),
        ),
      ],
    );
  }
}

class _FirstAppearance extends StatelessWidget {
  const _FirstAppearance({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  @override
  Widget build(BuildContext context) {
    return Column(      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          'First appearance',
          style: TextStyle(fontSize: 14, color: onPrimaryContainerColor),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          character.origin.name,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: onPrimaryContainerColor,),
        ),
      ],
    );
  }
}

class _AliveStatus extends StatelessWidget {
  const _AliveStatus({
    super.key,
    required this.color,
    required this.status,
  });

  final Color color;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
          size: 15,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          status,
          style: TextStyle(fontSize: 16, color: onPrimaryContainerColor),
        )
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({
    super.key,
    required this.character,
  });

  final RickAndMortyCharacter character;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(character.image)));
  }
}
