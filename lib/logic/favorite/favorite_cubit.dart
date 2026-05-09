import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/song.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final Box<Song> _favoriteBox = Hive.box<Song>("favorite");
  FavoriteCubit() : super(FavoriteInitial()) {
    loadFavoriteSong();
  }

  void loadFavoriteSong() {
    final songs = _favoriteBox.values.toList().cast<Song>();
    emit(FavoriteLoaded(songs));
  }

  bool isFavorite(int songId) {
    return _favoriteBox.containsKey(songId);
  }

  void toggleFavorite(Song song) async {
    if (_favoriteBox.containsKey(song.id)) {
      await _favoriteBox.delete(song.id);
    } else {
      await _favoriteBox.put(song.id, song);
    }
    loadFavoriteSong();
  }
}
