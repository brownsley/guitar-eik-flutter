import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/constants/app_constants.dart';
import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/presentation/widgets/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

class ArtistDetailScreen extends StatefulWidget {
  const ArtistDetailScreen({super.key});

  @override
  State<ArtistDetailScreen> createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      context.read<ArtistDetailCubit>().artistDetailLoad(id);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<ArtistDetailCubit, ArtistDetailState>(
          builder: (context, state) {
            if (state is ArtistDetailLoading) {
              return const LoadingView();
            }

            if (state is ArtistDetailError) {
              return Center(
                child: Text(
                  "Connection Error",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              );
            }

            if (state is ArtistDetailLoaded) {
              final artist = state.artistDetail;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                AppConstants.getImageUrl(
                                  AppConstants.artistFolder,
                                  artist.avatar,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  artist.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${artist.totalTrack} Tracks",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (artist.albums.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Albums",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: artist.albums.length,
                          itemBuilder: (context, index) {
                            final album = artist.albums[index];

                            return SizedBox(
                              width: 360,
                              child: AlbumCard(
                                albumTitle: album.name,
                                coverUrl: album.cover,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  "/album",
                                  arguments: album.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Songs",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: artist.songs.length,
                      itemBuilder: (context, index) {
                        final song = artist.songs[index];

                        return SongListItem(
                          id: song.id,
                          title: song.title,
                          cover: song.cover,
                          artists: song.artists ?? [],
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/song",
                            arguments: song.id,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
