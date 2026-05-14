import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/navigation/navigation_cubit.dart';
import 'package:guitar_eik/presentation/pages/album_page.dart';
import 'package:guitar_eik/presentation/pages/artist_page.dart';
import 'package:guitar_eik/presentation/pages/home_page.dart';
import 'package:guitar_eik/presentation/pages/setting_page.dart';
import 'package:guitar_eik/presentation/pages/song_page.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key, required this.title});
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => context.read<NavigationCubit>().changeTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 32),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music, size: 32),
            label: "Songs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album, size: 32),
            label: "Album",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 32),
            label: "Artist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 32),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
