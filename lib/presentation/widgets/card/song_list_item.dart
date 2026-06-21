import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/constants/app_constants.dart';
import 'package:guitar_eik/logic/favorite/favorite_cubit.dart';
import 'package:guitar_eik/model/song.dart';

class SongListItem extends StatelessWidget {
  final int id;
  final String title;
  final String cover;
  final List<String> artists;
  final VoidCallback? onTap;

  const SongListItem({
    super.key,
    required this.id,
    required this.title,
    required this.cover,
    required this.artists,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        AppConstants.getImageUrl(
                          AppConstants.songFolder,
                          cover,
                        ),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: colorScheme.surfaceVariant,
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.grey,
                              size: 40,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          artists.isNotEmpty ? artists.join(", ") : "Unknown",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite = context
                          .read<FavoriteCubit>()
                          .isFavorite(id);
                      return IconButton(
                        onPressed: () {
                          final songToSave = Song(
                            id: id,
                            title: title,
                            cover: cover,
                            artists: artists,
                          );
                          context.read<FavoriteCubit>().toggleFavorite(
                            songToSave,
                          );
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 30,
                          color: isFavorite
                              ? colorScheme.error
                              : colorScheme.outline,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
