import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/card/artist_card.dart';
import 'package:guitar_eik/presentation/widgets/components/skeleton/artists_loading.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/banner_ads.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/home_hero_ads.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/home_song_list.dart';
import 'package:guitar_eik/presentation/widgets/components/ui/song_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            fontSize: 14,
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
                    return const Center(child: ListLoading());
                  }
                  if (state is ArtistLoaded) {
                    final artists = state.artists;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: artists.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemBuilder: (context, index) {
                        final artist = artists[index];
                        return SizedBox(
                          width: 180,
                          child: ArtistCard(
                            artistName: artist.name,
                            imageUrl: artist.avatar,
                            totalSongs: artist.totalTrack!,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/artist",
                                arguments: artist.id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (state is ArtistError) {
                    return Center(child: Text("Error: ${state.error}"));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            SectionHeader(title: "Top Charts", isDark: isDark),
            const HomeSongList(),

            SectionHeader(title: "New Releases", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              title: "Special Limited Offer",
              subtitle: "Get 15% Discount This Month",
              imageUrl:
                  "https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=800&q=80",
              onTap: () {
                print("Redeeming 15% Discount...");
              },
            ),
            SectionHeader(title: "Trending Now", isDark: isDark),
            const HomeSongList(),
            SectionHeader(title: "Global Hits", isDark: isDark),
            const HomeSongList(),
            BannerAds(
              title: "Go Premium. Be Happy.",
              subtitle: "Enjoy ad-free music and high-quality audio.",
              imageUrl:
                  "https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?w=1000&q=80",
              onTap: () => print("Premium Ad Tapped"),
            ),
            SectionHeader(title: "Recently Played", isDark: isDark),
            const HomeSongList(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
