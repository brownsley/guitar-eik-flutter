import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
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
    final isDark = context.watch<ThemeCubit>().state;

    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,

      body: BlocBuilder<ArtistDetailCubit, ArtistDetailState>(
        builder: (context, state) {
          if (state is ArtistDetailLoading) {
            return const LoadingView();
          }

          if (state is ArtistDetailError) {
            return Center(
              child: Text(
                "Connection Error",
                style: TextStyle(color: textColor),
              ),
            );
          }

          if (state is ArtistDetailLoaded) {
            final artist = state.artistDetail;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(artist.avatar, fit: BoxFit.cover),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      artist.name,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${artist.totalTrack} Tracks",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  if (artist.albums.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Albums",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
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
                            width: 380,
                            child: AlbumCard(
                              albumTitle: album.name,
                              coverUrl: album.cover,

                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/album",
                                  arguments: album.id,
                                );
                              },
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
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
                        title: song.title,
                        artists: song.artists ?? [],
                        views: song.totalView,
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
    );
  }
}
