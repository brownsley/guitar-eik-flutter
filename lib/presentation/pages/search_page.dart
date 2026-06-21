import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/card/album_card.dart';
import 'package:guitar_eik/presentation/widgets/card/song_list_item.dart';
import 'package:guitar_eik/presentation/widgets/list/artists_list.dart';
import 'package:guitar_eik/presentation/widgets/ui/section_header.dart';
import 'package:guitar_eik/presentation/widgets/utils/empty_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(OnResetSearch());
  }

  @override
  void dispose() {
    context.read<SearchBloc>().add(OnResetSearch());
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDarkMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: "Search Artist or Songs",
                        hintStyle: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                      ),
                      onChanged: (value) =>
                          context.read<SearchBloc>().add(OnQueryChanged(value)),
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
                          SectionHeader(title: "ARTISTS", isDark: isDarkMode),
                          SizedBox(
                            height: 260,
                            child: ArtistHorizontalList(artists: state.artists),
                          ),
                        ],
                        if (state.albums.isNotEmpty) ...[
                          SectionHeader(title: "ALBUMS", isDark: isDarkMode),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              itemCount: state.albums.length.clamp(0, 20),
                              itemBuilder: (context, index) {
                                final album = state.albums[index];
                                return SizedBox(
                                  width: 320,
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
                          SectionHeader(title: "SONGS", isDark: isDarkMode),
                          ...state.songs
                              .take(20)
                              .map(
                                (song) => SongListItem(
                                  id: song.id,
                                  title: song.title,
                                  cover: song.cover,
                                  artists: song.artists ?? [],
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
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
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
}
