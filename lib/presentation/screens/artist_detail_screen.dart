import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

class ArtistDetailScreen extends StatefulWidget {
  const ArtistDetailScreen({super.key});

  @override
  State<ArtistDetailScreen> createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      context.read<ArtistDetailCubit>().artistDetailLoad(id);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistDetailCubit, ArtistDetailState>(
      builder: (context, state) {
        if (state is ArtistDetailLoading) {
          return LoadingView();
        }

        if (state is ArtistDetailLoaded) {
          final artist = state.artistDetail;
          return Scaffold(
            appBar: AppBar(title: Text(artist.name)),
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1. Avatar with Border Radius
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        artist.avatar,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16), // Space between image and text
                    // 2. Artist Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            artist.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${artist.totalTrack} Songs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 3. YouTube Button (Minimalist version)
                          InkWell(
                            onTap: () {
                              // YouTube link logic
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "YouTube",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: artist.songs.length,
                    itemBuilder: (context, index) {
                      final song = artist.songs[index];
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(song.title),
                        trailing: Text("${song.totalView} views"),
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
                ),
              ],
            ),
          );
        }
        if (state is ArtistDetailError) {
          return Text("Error");
        }
        return Container();
      },
    );
  }
}
