import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/artist_card.dart';
import 'package:guitar_eik/presentation/widgets/components/shimmer/artists_loading.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});
  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<ArtistCubit>().load();

    _scrollController.addListener(() {
      final state = context.read<ArtistCubit>().state;
      if (state is ArtistLoaded && !state.isLast) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
          context.read<ArtistCubit>().loadMore();
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
          "ARTISTS",
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
            icon: Icon(Icons.search, size: 28),
          ),
        ],
      ),
      body: BlocBuilder<ArtistCubit, ArtistState>(
        builder: (context, state) {
          if (state is ArtistLoading) {
            return const Center(child: ArtistsListLoading(3));
          }

          if (state is ArtistLoaded) {
            if (state.artists.isEmpty) {
              return const Center(child: Text("No artists found."));
            }

            return RefreshIndicator(
              onRefresh: () => context.read<ArtistCubit>().load(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 1024
                            ? 5
                            : (MediaQuery.of(context).size.width > 600 ? 4 : 2),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final artist = state.artists[index];
                        return ArtistCard(
                          imageUrl: artist.avatar,
                          artistName: artist.name,
                          totalSongs: artist.totalTrack!,
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/artist",
                            arguments: artist.id,
                          ),
                        );
                      }, childCount: state.artists.length),
                    ),
                  ),

                  if (!state.isLast)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
            );
          }

          if (state is ArtistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.read<ArtistCubit>().load(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
