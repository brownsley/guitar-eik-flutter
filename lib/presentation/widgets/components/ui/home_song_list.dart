import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_card.dart';
import 'package:guitar_eik/presentation/widgets/components/skeleton/songs_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSongList extends StatelessWidget {
  const HomeSongList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;

    return BlocBuilder<SongCubit, SongState>(
      builder: (context, state) {
        if (state is SongLoading) {
          return const SizedBox(child: Center(child: SongsLoading()));
        }

        if (state is SongLoaded) {
          final songs = state.songs;

          if (songs.isEmpty) {
            return const SizedBox(
              child: Center(child: Text("No songs found.")),
            );
          }

          return SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return SongCard(
                  title: song.title,
                  artist: (song.artists!.isEmpty)
                      ? "Unknown"
                      : song.artists!.first.name,
                  views: song.totalView,
                  isDark: isDark,
                  onTap: () {
                    Navigator.pushNamed(context, "/song", arguments: song.id);
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
