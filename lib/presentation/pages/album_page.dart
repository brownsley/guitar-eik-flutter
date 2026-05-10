import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/album_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/components/shimmer/albums_page_loading.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  // ignore: unused_field
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AlbumCubit>().load();

    _scrollController.addListener(() {
      final state = context.read<AlbumCubit>().state;
      if (state is AlbumLoaded && !state.isLast) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
          context.read<AlbumCubit>().loadMore();
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
            return AlbumPageLoading(8);
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
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: state.isLast
                    ? state.albums.length
                    : state.albums.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.albums.length) {
                    final album = state.albums[index];
                    return AlbumCard(
                      albumTitle: album.name,
                      coverUrl: album.cover,
                      onTap: () => Navigator.pushNamed(
                        context,
                        "/album",
                        arguments: album.id,
                      ),
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

          return const SizedBox();
        },
      ),
    );
  }
}
