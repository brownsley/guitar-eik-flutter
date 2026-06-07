import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guitar_eik/core/theme/extension.dart';

class AppTheme {
  static const Color slateBgLight = Color(0xFFF8FAFC);
  static const Color slateBgDark = Color(0xFF0F172A);
  static const Color slateSurfaceDark = Color(0xFF1E293B);
  static const Color slateAccent = Color(0xFF38BDF8);
  static const Color charcoalText = Color(0xFF334155);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: slateBgLight,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,

    textTheme: GoogleFonts.padaukTextTheme().copyWith(
      bodyMedium: const TextStyle(height: 1.6, color: charcoalText),
      bodyLarge: const TextStyle(
        height: 1.6,
        fontSize: 16,
        color: Color(0xFF1E293B),
      ),
      titleLarge: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F172A),
        letterSpacing: 0.2,
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: slateAccent,
      brightness: Brightness.light,
      primary: const Color(0xFF0F172A),
      onPrimary: Colors.white,
      surface: slateBgLight,
      surfaceContainerLow: Colors.white,
      outlineVariant: const Color(0xFFE2E8F0),
      onSurfaceVariant: const Color(0xFF64748B),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: slateBgLight,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Color(0xFF0F172A)),
      titleTextStyle: TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    extensions: [
      AppColorsExtension(
        lyricColor: const Color(0xFF0F172A),
        lyricBackground: Colors.white,
      ),
    ],
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: slateBgDark,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,

    textTheme: GoogleFonts.padaukTextTheme().copyWith(
      bodyMedium: const TextStyle(height: 1.6, color: Color(0xFF94A3B8)),
      bodyLarge: const TextStyle(
        height: 1.6,
        fontSize: 16,
        color: Color(0xFFF1F5F9),
      ),
      titleLarge: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      displaySmall: const TextStyle(
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: slateAccent,
      brightness: Brightness.dark,
      primary: slateAccent,
      onPrimary: slateBgDark,
      surface: slateBgDark,
      surfaceContainerLow: slateSurfaceDark,
      outlineVariant: Colors.white.withOpacity(0.05),
      onSurface: Colors.white,
      onSurfaceVariant: const Color(0xFF64748B),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: slateBgDark,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),

    cardTheme: CardThemeData(
      color: slateSurfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
      ),
    ),

    extensions: [
      AppColorsExtension(
        lyricColor: Colors.white,
        lyricBackground: slateSurfaceDark,
      ),
    ],
  );
}
