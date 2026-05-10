import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/components/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/components/list/artists_list.dart';
import 'package:guitar_eik/presentation/widgets/utils/empty_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    _searchBloc.add(OnResetSearch());
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;

    final Color backgroundColor = isDark
        ? const Color(0xFF121212)
        : Colors.white;
    final Color containerColor = isDark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFF2EDED);
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white70 : Colors.black54;
    final Color hintColor = isDark ? Colors.grey[500]! : Colors.grey[600]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(textColor, containerColor, hintColor),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchSuccess) {
                    if (state.artists.isEmpty &&
                        state.songs.isEmpty &&
                        state.albums.isEmpty) {
                      return const EmptyPage();
                    }
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (state.artists.isNotEmpty) ...[
                          _buildSectionTitle("Artists", textColor),
                          SizedBox(
                            height: 240,
                            child: ArtistHorizontalList(artists: state.artists),
                          ),
                        ],

                        if (state.albums.isNotEmpty) ...[
                          _buildSectionTitle("Albums", textColor),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              itemCount: state.albums.length > 20
                                  ? 20
                                  : state.albums.length,
                              itemBuilder: (context, index) {
                                final album = state.albums[index];
                                return SizedBox(
                                  width: 360,
                                  child: AlbumCard(
                                    albumTitle: album.name,
                                    coverUrl: album.cover,
                                    songCount: 0,
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      "/album",
                                      arguments: album.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        if (state.songs.isNotEmpty) ...[
                          _buildSectionTitle("Songs", textColor),
                          ...state.songs
                              .take(20)
                              .map(
                                (song) => SongListItem(
                                  title: song.title,
                                  artists: song.artists ?? [],
                                  views: song.totalView,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    "/song",
                                    arguments: song.id,
                                  ),
                                ),
                              ),
                        ],
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                  return Center(
                    child: Text(
                      "Search for your favorite artist",
                      style: TextStyle(color: subTextColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    Color textColor,
    Color containerColor,
    Color hintColor,
  ) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: "Search Artist or Songs",
                hintStyle: TextStyle(color: hintColor),
                prefixIcon: Icon(Icons.search, color: hintColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              onChanged: (value) {
                _searchBloc.add(OnQueryChanged(value));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
