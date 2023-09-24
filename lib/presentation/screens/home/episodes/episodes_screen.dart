import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/screens/home/episodes/controller/episode_controller.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

class EpisodesScreen extends ConsumerStatefulWidget {
  const EpisodesScreen({super.key});

  @override
  ConsumerState<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends ConsumerState<EpisodesScreen>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  bool canFetch = true;
  @override
  void initState() {
    super.initState();
    final notifier = ref.read(episodesProvider.notifier);
    final count = ref.read(episodesProvider).episodes.length;
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
    final episodes =
        ref.watch(episodesProvider.select((value) => value.episodes));
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: episodes.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (cntx, index) {
                    final episode = episodes[index];
                    var characters = episode.characters;

                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(episode.name),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: characters.map((e) {
                                  return _CharacterAvatarOrPlaceholder(url: e);
                                }).toList(),
                              ),
                            )
                          ],
                        ));
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

class _CharacterAvatarOrPlaceholder extends StatelessWidget {
  const _CharacterAvatarOrPlaceholder({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, _) {
      final character = ref.watch(
          charactersProvider.select((value) => value.cacheCharacter[url]));
      if (character?.id == 1) {
        print('RECONSTRUYENDO ID 1');
      }

      if (character == null) {
        // 1. Lo buscamos y añadimos al caché
        ref.read(charactersProvider.notifier).addOneToCache(url);
        return const CircleAvatar(
          child: Icon(Icons.person),
        );
      }
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: GestureDetector(
          onTap: () => {},
          child: CircleAvatar(
            backgroundColor: lightColorScheme.primary,
            maxRadius: 30,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider)),
              ),
              placeholder: (context, url) => Icon(Icons.person),
              imageUrl: character.image,
              cacheKey: character.image,
            ),
          ),
        ),
      );
    });
  }
}

class _LoadingPaginationSpinner extends ConsumerWidget {
  const _LoadingPaginationSpinner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(
        episodesProvider.select((value) => value.uiState.loadingPagination));
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
        ref.watch(episodesProvider.select((value) => value.uiState.loading));
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
