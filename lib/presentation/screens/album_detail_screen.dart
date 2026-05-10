import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/detail/album_detail_cubit.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

class AlbumDetailScreen extends StatefulWidget {
  const AlbumDetailScreen({super.key});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      context.read<AlbumDetailCubit>().loadDetail(id);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;

    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: BlocBuilder<AlbumDetailCubit, AlbumDetailState>(
        builder: (context, state) {
          if (state is AlbumDetailLoading) {
            return const LoadingView();
          }

          if (state is AlbumDetailError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: textColor)),
            );
          }

          if (state is AlbumDetailLoaded) {
            final album = state.album;
            final songs = album.songs;

            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: Image.network(album.cover, fit: BoxFit.cover),
                    ),

                    Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 6, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 250,
                //   child: ArtistHorizontalList(artists: state.album.artists),
                // ),
                Expanded(
                  child: Container(
                    color: backgroundColor,
                    child: ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];

                        return SongListItem(
                          title: song.title,
                          artists: song.artists ?? [],
                          views: song.totalView,
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/song",
                            arguments: song.id,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
