import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/song_list.dart';
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
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(Icons.search, size: 28),
          ),
        ],
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            context.read<SongCubit>().loadSongs();
            return Future.value();
          },
          child: BlocBuilder<SongCubit, SongState>(
            builder: (context, state) {
              if (state is SongLoading) {
                return LoadingView();
              }
              if (state is SongLoaded) {
                if (state.songs.isEmpty) {
                  return const Center(
                    child: Text('Welcome! Search for music.'),
                  );
                }
                return SongList(songs: state.songs);
              }
              return const Center(child: Text('Welcome! Search for music.'));
            },
          ),
        ),
      ),
    );
  }
}
