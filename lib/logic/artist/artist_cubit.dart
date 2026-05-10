import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/service/artist_service.dart';
import 'package:meta/meta.dart';

part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final ArtistService _artistService = ArtistService();
  bool _isFetching = false;

  ArtistCubit() : super(ArtistInitial());

  Future<void> load() async {
    try {
      emit(ArtistLoading());
      final response = await _artistService.getAllArtistSummary(page: 0);
      emit(
        ArtistLoaded(
          artists: response["artists"],
          isLast: response["isLast"],
          currentPage: 0,
        ),
      );
    } catch (e) {
      emit(ArtistError(error: e.toString()));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is ArtistLoaded && !currentState.isLast && !_isFetching) {
      _isFetching = true;

      try {
        int nextPage = currentState.currentPage + 1;
        final response = await _artistService.getAllArtistSummary(
          page: nextPage,
        );

        List<Artist> updatedList = List.from(currentState.artists)
          ..addAll(response["artists"]);

        emit(
          ArtistLoaded(
            artists: updatedList,
            isLast: response["isLast"],
            currentPage: nextPage,
          ),
        );
      } catch (e) {
        emit(ArtistError(error: e.toString()));
      } finally {
        _isFetching = false;
      }
    }
  }
}
