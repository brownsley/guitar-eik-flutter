import 'package:flutter/material.dart';
import 'package:guitar_eik/constants/app_constants.dart';

class AlbumCard extends StatelessWidget {
  final String albumTitle;
  final String coverUrl;
  final int songCount;
  final VoidCallback? onTap;

  const AlbumCard({
    super.key,
    required this.albumTitle,
    this.songCount = 10,
    required this.coverUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      AppConstants.getImageUrl(
                        AppConstants.albumFolder,
                        coverUrl,
                      ),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.album_rounded,
                          size: 30,
                          color: colorScheme.primary.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            albumTitle,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note_rounded,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$songCount Songs",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
