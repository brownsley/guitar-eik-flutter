import 'package:guitar_eik/core/theme/extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.padaukTextTheme().copyWith(
      bodyMedium: const TextStyle(height: 1.8), // Lyrics တွေအတွက် line height
      bodyLarge: const TextStyle(height: 1.8),
      titleMedium: const TextStyle(height: 1.5),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    extensions: [
      AppColorsExtension(
        lyricColor: const Color.fromARGB(255, 19, 18, 18),
        lyricBackground: const Color.fromARGB(255, 255, 255, 255),
      ),
    ],
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.padaukTextTheme().copyWith(
      bodyMedium: const TextStyle(height: 1.8),
      bodyLarge: const TextStyle(height: 1.8),
      titleMedium: const TextStyle(height: 1.5),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    extensions: [
      AppColorsExtension(
        lyricColor: const Color.fromARGB(255, 177, 177, 179),
        lyricBackground: const Color.fromARGB(255, 18, 18, 19),
      ),
    ],
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}
