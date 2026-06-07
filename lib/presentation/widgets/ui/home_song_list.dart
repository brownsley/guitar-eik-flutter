import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/shimmer/song_page_loading.dart';
import 'package:guitar_eik/presentation/widgets/ui/song_pager.dart';

class HomeSongList extends StatefulWidget {
  const HomeSongList({super.key});

  @override
  State<HomeSongList> createState() => _HomeSongListState();
}

class _HomeSongListState extends State<HomeSongList> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongCubit, SongState>(
      builder: (context, state) {
        if (state is SongLoading) {
          return const SongsPageLoading(2);
        }
        if (state is SongLoaded) {
          final songs = state.songs;
          if (songs.isEmpty) {
            return const Center(child: Text("No songs found."));
          }
          return SongPager(songs: state.songs);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
