import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/cubit/album_cubit.dart';
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
    context.read<AlbumCubit>().getAlbum();
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
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];

                return ListTile(
                  title: Text(album.name),
                  leading: Image.network(
                    album.cover,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
