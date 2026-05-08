import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guitar_eik/core/theme/app_theme.dart';
import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/logic/chord/chord_cubit.dart';
import 'package:guitar_eik/logic/cubit/album_cubit.dart';
import 'package:guitar_eik/logic/navigation/navigation_cubit.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/pages/album_page.dart';
import 'package:guitar_eik/presentation/pages/artist_page.dart';
import 'package:guitar_eik/presentation/pages/home_page.dart';
import 'package:guitar_eik/presentation/pages/search_page.dart';
import 'package:guitar_eik/presentation/pages/setting_page.dart';
import 'package:guitar_eik/presentation/pages/song_page.dart';
import 'package:guitar_eik/presentation/screens/artist_detail_screen.dart';
import 'package:guitar_eik/presentation/screens/chord_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = SharedPreferencesAsync();
  final bool savedTheme = await prefs.getBool('isDarkMode') ?? false;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(savedTheme)),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (create) => ChordCubit()),
        BlocProvider(create: (create) => SongCubit()),
        BlocProvider(create: (create) => ArtistCubit()),
        BlocProvider(create: (create) => ArtistDetailCubit()),
        BlocProvider(create: (create) => SearchBloc()),
        BlocProvider(create: (create) => AlbumCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

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

          home: const MyHomePage(title: 'Testing AOI'),
          routes: {
            "/song": (context) => ChordScreen(),
            "/artist": (context) => ArtistDetailScreen(),
            "/search": (context) => SearchPage(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  static const List<Widget> _pages = [
    HomePage(),
    SongPage(),
    AlbumPage(),
    ArtistPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<NavigationCubit>().state;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index) => context.read<NavigationCubit>().changeTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music_outlined, size: 30),
            label: "Songs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music_outlined, size: 30),
            label: "Album",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Artist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
