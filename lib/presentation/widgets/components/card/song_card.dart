import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final int views;
  final VoidCallback? onTap;
  final bool isDark;

  const SongCard({
    super.key,
    required this.title,
    required this.artist,
    required this.views,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryTextColor = isDark ? Colors.white38 : Colors.black45;
    final accentColor = Colors.deepPurpleAccent;
    final cardBg = isDark ? const Color(0xFF121212) : Colors.white;

    String formattedViews = views >= 1000
        ? '${(views / 1000).toStringAsFixed(1)}K'
        : '$views';

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.black12,
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            splashColor: accentColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    artist.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white70 : Colors.black87,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        size: 12,
                        color: accentColor,
                      ),
                      Text(
                        "$formattedViews VIEWS",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
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
