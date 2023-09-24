import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/models/episode.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.episode,
    required this.characters,
  });

  final Episode episode;
  final List<String> characters;

  @override
  Widget build(BuildContext context) {
    final splitEpisode = episode.episode.split('E');
    final episodeSeasonAndNumber =
        '${splitEpisode.first} Episode ${splitEpisode.last}';

    return Card(
      color: lightColorScheme.primaryContainer,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EpisodeNameAndAirDate(
                episodeSeasonAndNumber: episodeSeasonAndNumber,
                episode: episode),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Characters',
              style: TextStyle(
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                  color: lightColorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: characters.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1, maxCrossAxisExtent: 80),
                itemBuilder: (ctx, index) {
                  return _CharacterAvatarOrPlaceholder(url: characters[index]);
                }),
          ],
        ),
      ),
    );
  }
}

class _EpisodeNameAndAirDate extends StatelessWidget {
  const _EpisodeNameAndAirDate({
    super.key,
    required this.episodeSeasonAndNumber,
    required this.episode,
  });

  final String episodeSeasonAndNumber;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episodeSeasonAndNumber,
                style: TextStyle(
                    fontSize: 16, color: lightColorScheme.onPrimaryContainer),
              ),
              Text(
                episode.airDate,
                style: TextStyle(
                    fontSize: 16, color: lightColorScheme.onPrimaryContainer),
              )
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            episode.name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: lightColorScheme.onPrimaryContainer),
          )
        ],
      ),
    );
  }
}

class _CharacterAvatarOrPlaceholder extends StatelessWidget {
  const _CharacterAvatarOrPlaceholder({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Consumer(
        key: Key(url),
        builder: (ctx, ref, _) {
          final character = ref.watch(
              charactersProvider.select((value) => value.cacheCharacter[url]));

          if (character == null) {
            // 1. Lo buscamos y añadimos al caché
            ref.read(charactersProvider.notifier).addOneToCache(url);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              child: CircleAvatar(
                backgroundColor: lightColorScheme.primary,
                child: const Icon(Icons.person),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: () => {},
              child: CircleAvatar(
                backgroundColor: lightColorScheme.primary,
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 100),
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider)),
                  ),
                  placeholder: (context, url) => const Icon(Icons.person),
                  imageUrl: character.image,
                  cacheKey: character.image,
                ),
              ),
            ),
          );
        });
  }
}
