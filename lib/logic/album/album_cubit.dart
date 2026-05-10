import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/album_model.dart';
import 'package:guitar_eik/service/album_service.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumService _albumSercice = AlbumService();
  bool _isFetching = false;

  AlbumCubit() : super(AlbumInitial());

  Future<void> load() async {
    try {
      emit(AlbumLoading());
      final response = await _albumSercice.getAllAlbum(page: 0);
      emit(
        AlbumLoaded(
          albums: response["albums"],
          isLast: response["isLast"],
          currentPage: 0,
        ),
      );
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is AlbumLoaded && !currentState.isLast && !_isFetching) {
      _isFetching = true;
      try {
        int nextPage = currentState.currentPage + 1;
        final response = await _albumSercice.getAllAlbum(page: nextPage);
        List<Album> updateList = List.from(currentState.albums)
          ..addAll(response["albums"]);
        emit(
          AlbumLoaded(
            albums: updateList,
            isLast: response["isLast"],
            currentPage: nextPage,
          ),
        );
      } catch (e) {
        emit(AlbumError(e.toString()));
      } finally {
        _isFetching = false;
      }
    }
  }
}
