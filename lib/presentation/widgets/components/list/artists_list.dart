import 'package:flutter/material.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/presentation/widgets/components/card/artist_card.dart';

class ArtistHorizontalList extends StatelessWidget {
  final List<Artist> artists;
  const ArtistHorizontalList({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: artists.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemBuilder: (context, index) {
        final artist = artists[index];
        return SizedBox(
          width: 180,
          child: ArtistCard(
            artistName: artist.name,
            imageUrl: artist.avatar,
            totalSongs: artist.totalTrack!,
            onTap: () {
              Navigator.pushNamed(context, "/artist", arguments: artist.id);
            },
          ),
        );
      },
    );
  }
}
