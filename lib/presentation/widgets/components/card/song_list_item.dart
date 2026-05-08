import 'package:flutter/material.dart';

class SongListItem extends StatelessWidget {
  final String title;
  final String artist;
  final int views;
  final bool isDark;
  final VoidCallback? onTap;

  const SongListItem({
    super.key,
    required this.title,
    required this.artist,
    required this.views,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? Colors.white : Colors.black;
    final secondaryColor = isDark ? Colors.white54 : Colors.black54;
    final accentColor = Colors.deepPurpleAccent;

    String formattedViews = views >= 1000000
        ? '${(views / 1000000).toStringAsFixed(1)}M'
        : views >= 1000
        ? '${(views / 1000).toStringAsFixed(1)}K'
        : views.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF121212) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
          ),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  color: accentColor,
                  size: 25,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: secondaryColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedViews,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "VIEWS",
                    style: TextStyle(
                      fontSize: 9,
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Icon(
                Icons.chevron_right_rounded,
                color: secondaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
