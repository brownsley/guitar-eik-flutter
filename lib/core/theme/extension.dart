import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color? lyricColor;
  final Color? lyricBackground;
  const AppColorsExtension({
    required this.lyricColor,
    required this.lyricBackground,
  });

  @override
  AppColorsExtension copyWith({Color? lyricColor, Color? lyricBackground}) {
    return AppColorsExtension(
      lyricColor: lyricColor ?? this.lyricColor,
      lyricBackground: lyricBackground ?? this.lyricBackground,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      lyricColor: Color.lerp(lyricColor, other.lyricColor, t),
      lyricBackground: Color.lerp(lyricBackground, other.lyricBackground, t),
    );
  }
}
