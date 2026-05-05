import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        // if (state is ArtistDetailLoaded) {
        //   return Text("Success");
        // }
        if (state is ArtistDetailLoaded) {
          final artist = state.artistDetail;
          return Scaffold(
            appBar: AppBar(title: Text(artist.name)),
            body: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(artist.avatar),
                  ),
                  title: Text(
                    artist.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${artist.totalTrack} Songs available"),
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
