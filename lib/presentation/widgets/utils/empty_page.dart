import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color iconColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
    final Color mainTextColor = isDark ? Colors.grey[300]! : Colors.grey[800]!;
    final Color subTextColor = isDark ? Colors.grey[500]! : Colors.grey[500]!;
    final Color scaffoldBg = isDark ? const Color(0xFF121212) : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: mainTextColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 100, color: iconColor),
            const SizedBox(height: 10),

            Text(
              "No Results",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: mainTextColor,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "We couldn't find any matching songs, artists, or albums for your search.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: subTextColor, height: 1.4),
            ),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
