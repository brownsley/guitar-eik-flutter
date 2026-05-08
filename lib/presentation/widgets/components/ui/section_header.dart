import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const SectionHeader({super.key, required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFFF007F);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
