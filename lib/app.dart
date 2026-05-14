import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/core/theme/app_theme.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/pages/home/app_home_page.dart';
import 'package:guitar_eik/presentation/pages/search_page.dart';
import 'package:guitar_eik/presentation/pages/splash/slash_screen.dart';
import 'package:guitar_eik/presentation/screens/album_detail_screen.dart';
import 'package:guitar_eik/presentation/screens/artist_detail_screen.dart';
import 'package:guitar_eik/presentation/screens/chord_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return MaterialApp(
          title: "Testing AOI",
          debugShowCheckedModeBanner: false,
          theme: state ? AppTheme.darkTheme : AppTheme.lightTheme,

          home: const SplashScreen(),

          routes: {
            "/home": (context) => const AppHomePage(title: 'Testing AOI'),
            "/song": (context) => const ChordScreen(),
            "/artist": (context) => const ArtistDetailScreen(),
            "/album": (context) => const AlbumDetailScreen(),
            "/search": (context) => const SearchPage(),
          },
        );
      },
    );
  }
}
