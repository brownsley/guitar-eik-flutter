import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/album_cubit.dart';
import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/logic/favorite/favorite_cubit.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/list/artists_list.dart';
import 'package:guitar_eik/presentation/widgets/shimmer/albums_page_loading.dart';
import 'package:guitar_eik/presentation/widgets/shimmer/artists_loading.dart';
import 'package:guitar_eik/presentation/widgets/ui/album_pager.dart';
import 'package:guitar_eik/presentation/widgets/ui/banner_ads.dart';
import 'package:guitar_eik/presentation/widgets/ui/home_hero_ads.dart';
import 'package:guitar_eik/presentation/widgets/ui/home_song_list.dart';
import 'package:guitar_eik/presentation/widgets/ui/section_header.dart';
import 'package:guitar_eik/presentation/widgets/ui/song_pager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<SongCubit>().loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "DISCOVER",
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeroAds(),
            SectionHeader(title: "ARTISTS", isDark: isDark),
            SizedBox(
              height: 250,
              child: BlocBuilder<ArtistCubit, ArtistState>(
                builder: (context, state) {
                  if (state is ArtistLoading) {
                    return const Center(child: ArtistsListLoading(1));
                  }
                  if (state is ArtistLoaded) {
                    if (state.artists.isEmpty) {
                      return Center(
                        child: Text(
                          "No Artist Found",
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      );
                    }
                    return ArtistHorizontalList(artists: state.artists);
                  }
                  if (state is ArtistError) {
                    return Center(
                      child: Text(
                        "Error: ${state.error}",
                        style: TextStyle(color: colorScheme.error),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoaded) {
                  final songs = state.favoriteSongs;
                  if (songs.isEmpty) return const SizedBox.shrink();
                  return Column(
                    children: [
                      SectionHeader(title: "Favorites", isDark: isDark),
                      SongPager(songs: state.favoriteSongs),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SectionHeader(title: "Top Albums", isDark: isDark),
            BlocBuilder<AlbumCubit, AlbumState>(
              builder: (context, state) {
                if (state is AlbumLoading) {
                  return const AlbumPageLoading(2);
                }
                if (state is AlbumLoaded) {
                  final albums = state.albums;
                  if (albums.isEmpty) return const SizedBox.shrink();
                  return AlbumPager(albums: albums);
                }
                return const SizedBox.shrink();
              },
            ),
            BannerAds(
              imageUrl:
                  "https://mpt-aws-wp-bucket.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2024/01/30104605/Note4U_1400x430.jpg",
              onTap: () {},
            ),
            SectionHeader(title: "RECENT ADD", isDark: isDark),
            const HomeSongList(),
            SectionHeader(title: "MOST POPULAR", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              imageUrl:
                  "https://cdn.wavemoney.com.mm/wp-content/uploads/2C2P_Website-Banner_1930x670px-4-scaled.jpg",
              onTap: () {},
            ),
            SectionHeader(title: "Trending Now", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              imageUrl:
                  "https://mpt-aws-wp-bucket.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2025/07/17171523/A-Kyite-PoeAuto-Renewal_07-1400x430-1.jpg",
              onTap: () {},
            ),
            SectionHeader(title: "Random Pick", isDark: isDark),
            const HomeSongList(),
          ],
        ),
      ),
    );
  }
}
