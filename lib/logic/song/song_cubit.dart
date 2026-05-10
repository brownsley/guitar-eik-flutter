import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/service/song_service.dart';
import 'package:meta/meta.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  final SongService _songService = SongService();
  bool _isFetching = false;

  SongCubit() : super(SongInitial());

  Future<void> loadSongs() async {
    try {
      emit(SongLoading());
      final response = await _songService.getAllSongSummary();
      emit(
        SongLoaded(
          songs: response["songs"],
          isLast: response["isLast"],
          currentPage: 0,
        ),
      );
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is SongLoaded && !currentState.isLast && !_isFetching) {
      _isFetching = true;
      try {
        int nextPage = currentState.currentPage + 1;
        final response = await _songService.getAllSongSummary(page: nextPage);
        List<Song> updateList = List.from(currentState.songs)
          ..addAll(response["songs"]);
        emit(
          SongLoaded(
            songs: updateList,
            isLast: response["isLast"],
            currentPage: nextPage,
          ),
        );
      } catch (e) {
        emit(SongError(e.toString()));
      } finally {
        _isFetching = false;
      }
    }
  }
}
