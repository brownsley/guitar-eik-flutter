import 'package:flutter/material.dart';
import 'package:guitar_eik/presentation/widgets/components/card/album_card.dart';

class AlbumPager extends StatefulWidget {
  final List albums;

  const AlbumPager({super.key, required this.albums});

  @override
  State<AlbumPager> createState() => _AlbumPagerState();
}

class _AlbumPagerState extends State<AlbumPager> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final limitedAlbums = widget.albums.take(12).toList();
    final pageCount = (limitedAlbums.length / 2).ceil();

    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pageCount,
        itemBuilder: (context, pageIndex) {
          final firstIndex = pageIndex * 2;
          final secondIndex = firstIndex + 1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlbumCard(
                albumTitle: limitedAlbums[firstIndex].name,
                coverUrl: limitedAlbums[firstIndex].cover ?? "",
                songCount: 0,
                onTap: () => Navigator.pushNamed(
                  context,
                  "/album",
                  arguments: limitedAlbums[firstIndex].id,
                ),
              ),

              if (secondIndex < limitedAlbums.length)
                AlbumCard(
                  albumTitle: limitedAlbums[secondIndex].name,
                  coverUrl: limitedAlbums[secondIndex].cover ?? "",
                  songCount: 0,
                  onTap: () => Navigator.pushNamed(
                    context,
                    "/album_details",
                    arguments: limitedAlbums[secondIndex].id,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
