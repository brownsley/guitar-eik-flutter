import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/constants/app_constants.dart';
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
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<AlbumDetailCubit, AlbumDetailState>(
        builder: (context, state) {
          if (state is AlbumDetailLoading) return const LoadingView();
          if (state is AlbumDetailError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: colorScheme.error),
              ),
            );
          }

          if (state is AlbumDetailLoaded) {
            final album = state.album;
            final songs = album.songs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        AppConstants.getImageUrl(
                          AppConstants.albumFolder,
                          album.cover,
                        ),
                        height: 220,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      album.name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: songs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 2),
                    itemBuilder: (context, index) {
                      final song = songs[index];
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
    );
  }
}
