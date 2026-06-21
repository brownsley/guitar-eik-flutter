import 'package:flutter/material.dart';
import 'package:guitar_eik/constants/app_constants.dart';

class ArtistCard extends StatelessWidget {
  final String artistName;
  final String? imageUrl;
  final int totalSongs;
  final VoidCallback? onTap;

  const ArtistCard({
    super.key,
    required this.artistName,
    this.totalSongs = 12,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Forces a perfect square regardless of image dimensions
              LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.maxWidth;
                  return SizedBox(
                    width: size,
                    height: size,
                    child: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? Image.network(
                            AppConstants.getImageUrl(
                              AppConstants.artistFolder,
                              imageUrl!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.person,
                              size: size * 0.4,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artistName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 14,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "$totalSongs Tracks",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
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
    );
  }
}
