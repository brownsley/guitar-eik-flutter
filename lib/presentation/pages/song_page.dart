import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/shimmer/song_page_loading.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<SongCubit>().loadSongs();

    _scrollController.addListener(() {
      final state = context.read<SongCubit>().state;
      if (state is SongLoaded && !state.isLast) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
          context.read<SongCubit>().loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              return const SongsPageLoading(8);
            }

            if (state is SongLoaded) {
              if (state.songs.isEmpty) {
                return const Center(child: Text('No songs found.'));
              }
              return RefreshIndicator(
                onRefresh: () => context.read<SongCubit>().loadSongs(),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.isLast
                      ? state.songs.length
                      : state.songs.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.songs.length) {
                      final song = state.songs[index];

                      return SongListItem(
                        views: song.totalView,
                        title: song.title,
                        artists: song.artists ?? [],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/song",
                            arguments: song.id,
                          );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 4),
                        ),
                      );
                    }
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
