import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/album_model.dart';
import 'package:guitar_eik/service/album_service.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumService _albumSercice = AlbumService();
  AlbumCubit() : super(AlbumInitial());

  Future<void> getAlbum() async {
    try {
      emit(AlbumLoading());
      final reponse = await _albumSercice.getAllAlbum();
      emit(AlbumLoaded(reponse));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}
