import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/detail/album_detail_cubit.dart';
import 'package:guitar_eik/presentation/widgets/card/song_list_item.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: BlocBuilder<AlbumDetailCubit, AlbumDetailState>(
        builder: (context, state) {
          if (state is AlbumDetailLoading) {
            return const LoadingView();
          }

          if (state is AlbumDetailError) {
            return Center(
              child: Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Container(
                    color: colorScheme.surface,
                    child: ListView.builder(
                      itemCount: songs.length,
                      padding: EdgeInsets.zero,
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
