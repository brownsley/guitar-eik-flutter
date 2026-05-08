import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/service/song_service.dart';
import 'package:meta/meta.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  final SongService _songService = SongService();
  SongCubit() : super(SongInitial());

  Future<void> loadSongs() async {
    try {
      emit(SongLoading());
      final response = await _songService.getAllSongSummary();
      emit(SongLoaded(response));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }
}
