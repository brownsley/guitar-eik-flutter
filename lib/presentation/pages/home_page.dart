import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/album/album_cubit.dart';
import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/logic/favorite/favorite_cubit.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/list/artists_list.dart';
import 'package:guitar_eik/presentation/widgets/components/shimmer/albums_page_loading.dart';
import 'package:guitar_eik/presentation/widgets/components/shimmer/artists_loading.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/album_pager.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/banner_ads.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/home_hero_ads.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/home_song_list.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/section_header.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/song_pager.dart';

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark
        ? const Color(0xFF000000)
        : const Color(0xFFF8F8F8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "DISCOVER",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
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
                      return Text("No Artist Found");
                    }
                    return ArtistHorizontalList(artists: state.artists);
                  }

                  if (state is ArtistError) {
                    return Center(child: Text("Error: ${state.error}"));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoaded) {
                  final songs = state.favoriteSongs;

                  if (songs.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return Column(
                    children: [
                      SectionHeader(title: "Favorites", isDark: isDark),

                      SongPager(songs: state.favoriteSongs),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
            SectionHeader(title: "Top Albums", isDark: isDark),

            BlocBuilder<AlbumCubit, AlbumState>(
              builder: (context, state) {
                if (state is AlbumLoading) {
                  return AlbumPageLoading(2);
                }
                if (state is AlbumLoaded) {
                  final albums = state.albums;
                  if (albums.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return AlbumPager(albums: albums);
                }
                return SizedBox.shrink();
              },
            ),
            BannerAds(
              imageUrl:
                  "https://mpt-aws-wp-bucket.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2024/01/30104605/Note4U_1400x430.jpg",
              onTap: () {
                print("Redeeming 15% Discount...");
              },
            ),
            SectionHeader(title: "RECENT ADD", isDark: isDark),
            const HomeSongList(),

            SectionHeader(title: "MOST POPULAR", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              imageUrl:
                  "https://cdn.wavemoney.com.mm/wp-content/uploads/2C2P_Website-Banner_1930x670px-4-scaled.jpg",
              onTap: () {
                print("Redeeming 15% Discount...");
              },
            ),
            SectionHeader(title: "Trending Now", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              imageUrl:
                  "https://mpt-aws-wp-bucket.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2025/07/17171523/A-Kyite-PoeAuto-Renewal_07-1400x430-1.jpg",
              onTap: () {
                print("Redeeming 15% Discount...");
              },
            ),
            SectionHeader(title: "Random Pick", isDark: isDark),
            const HomeSongList(),
          ],
        ),
      ),
    );
  }
}
