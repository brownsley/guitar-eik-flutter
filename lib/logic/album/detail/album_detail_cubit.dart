import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/album_detail_model.dart';
import 'package:guitar_eik/service/album_service.dart';
import 'package:meta/meta.dart';

part 'album_detail_state.dart';

class AlbumDetailCubit extends Cubit<AlbumDetailState> {
  final AlbumService _albumService = AlbumService();
  AlbumDetailCubit() : super(AlbumDetailInitial());

  Future<void> loadDetail(int id) async {
    try {
      emit(AlbumDetailLoading());
      final response = await _albumService.getAlbumDetail(id);
      emit(AlbumDetailLoaded(album: response));
    } catch (e) {
      emit(AlbumDetailError(e.toString()));
    }
  }
}
