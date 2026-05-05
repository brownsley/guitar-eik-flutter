import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
import 'package:flutter/material.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;

  const SongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.builder(
      itemCount: songs.length,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final song = songs[index];

        return SongListItem(
          views: song.totalView,
          title: song.title,
          artist: (song.artists?.isNotEmpty ?? false)
              ? song.artists?.first.name ?? "Unknown"
              : "Unknown",
          isDark: isDark,
          onTap: () {
            Navigator.pushNamed(context, "/song", arguments: song.id);
          },
        );
      },
    );
  }
}
