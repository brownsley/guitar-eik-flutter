import 'package:flutter/material.dart';
import 'package:guitar_eik/presentation/widgets/card/song_list_item.dart';

class SongPager extends StatefulWidget {
  final List songs;

  const SongPager({super.key, required this.songs});

  @override
  State<SongPager> createState() => _SongPagerState();
}

class _SongPagerState extends State<SongPager> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final limitedSongs = widget.songs.take(12).toList();
    final pageCount = (limitedSongs.length / 2).ceil();

    return SizedBox(
      height: 175,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pageCount,
        itemBuilder: (context, pageIndex) {
          final firstIndex = pageIndex * 2;
          final secondIndex = firstIndex + 1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SongListItem(
                title: limitedSongs[firstIndex].title,
                artists: limitedSongs[firstIndex].artists ?? [],
                views: limitedSongs[firstIndex].totalView,
                onTap: () => Navigator.pushNamed(
                  context,
                  "/song",
                  arguments: limitedSongs[firstIndex].id,
                ),
              ),

              if (secondIndex < limitedSongs.length)
                SongListItem(
                  title: limitedSongs[secondIndex].title,
                  artists: limitedSongs[firstIndex].artists ?? [],
                  views: limitedSongs[secondIndex].totalView,
                  onTap: () => Navigator.pushNamed(
                    context,
                    "/song",
                    arguments: limitedSongs[secondIndex].id,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
