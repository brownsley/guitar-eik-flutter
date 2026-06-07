import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guitar_eik/app.dart';
import 'package:guitar_eik/logic/album/album_cubit.dart';
import 'package:guitar_eik/logic/album/detail/album_detail_cubit.dart';
import 'package:guitar_eik/logic/artist/artist_cubit.dart';
import 'package:guitar_eik/logic/artist/detail/artist_detail_cubit.dart';
import 'package:guitar_eik/logic/chord/chord_cubit.dart';
import 'package:guitar_eik/logic/favorite/favorite_cubit.dart';
import 'package:guitar_eik/logic/navigation/navigation_cubit.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';
import 'package:guitar_eik/logic/song/song_cubit.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/model/song.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter(SongAdapter());
  await Hive.openBox<Song>("favorite");

  final prefs = await SharedPreferences.getInstance();
  final bool savedTheme = prefs.getBool('isDarkMode') ?? false;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(savedTheme)),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => ChordCubit()),
        BlocProvider(create: (context) => SongCubit()),
        BlocProvider(create: (context) => ArtistCubit()),
        BlocProvider(create: (context) => ArtistDetailCubit()),
        BlocProvider(create: (context) => AlbumDetailCubit()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => AlbumCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
