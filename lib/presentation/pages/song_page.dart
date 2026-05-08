import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  void initState() {
    super.initState();
    // ပထမဆုံးအကြိမ် Load လုပ်မယ်
    context.read<SongCubit>().loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SONGS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/search"),
            icon: const Icon(Icons.search, size: 28),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            if (state is SongLoading) {
              return const LoadingView();
            }

            if (state is SongLoaded) {
              if (state.songs.isEmpty) {
                return const Center(child: Text('No songs found.'));
              }
              return RefreshIndicator(
                onRefresh: () => context.read<SongCubit>().loadSongs(),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.songs.length,
                  itemBuilder: (context, index) {
                    final song = state.songs[index];

                    return SongListItem(
                      views: song.totalView,
                      title: song.title,
                      artist: (song.artists?.isNotEmpty ?? false)
                          ? song.artists?.first.name ?? "Unknown"
                          : "Unknown",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/song",
                          arguments: song.id,
                        );
                      },
                    );
                  },
                ),
              );
            }

            if (state is SongError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return const Center(child: Text('Welcome! Search for music.'));
          },
        ),
      ),
    );
  }
}
