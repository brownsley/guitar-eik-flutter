import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/album_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "ALBUMS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(Icons.search, size: 28),
          ),
        ],
      ),

      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return LoadingView();
          }

          if (state is AlbumError) {
            return Center(child: Text(state.message));
          }

          if (state is AlbumLoaded) {
            if (state.albums.isEmpty) {
              return const Center(child: Text("No artists found."));
            }
            return RefreshIndicator(
              onRefresh: () => context.read<AlbumCubit>().load(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];

                  return AlbumCard(
                    albumTitle: album.name,
                    coverUrl: album.cover,
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
