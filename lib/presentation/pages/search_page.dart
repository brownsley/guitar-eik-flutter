import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/components/list/artists_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 223, 223),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search Artist or Songs",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                      ),
                      onChanged: (value) {
                        context.read<SearchBloc>().add(OnQueryChanged(value));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is SearchSuccess) {
                    if (state.artists.isEmpty && state.songs.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey,
                            ),
                            Text("No results found"),
                          ],
                        ),
                      );
                    }
                    return ListView(
                      children: [
                        if (state.artists.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Artists",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            child: ArtistHorizontalList(artists: state.artists),
                          ),
                        ],
                        if (state.songs.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Songs",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
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
                        ],
                      ],
                    );
                  }

                  return const Center(
                    child: Text("Search for your favorite artist"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
