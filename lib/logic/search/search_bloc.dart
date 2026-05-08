import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/service/artist_service.dart';
import 'package:guitar_eik/service/song_service.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ArtistService artistService = ArtistService();
  SongService songService = SongService();
  SearchBloc() : super(SearchInitial()) {
    on<OnQueryChanged>(
      _onSearch,
      transformer: (events, mapper) {
        return events
            .debounceTime(Duration(microseconds: 5000))
            .switchMap(mapper);
      },
    );
  }

  Future<void> _onSearch(
    OnQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(SearchInitial());
    }
    emit(SearchLoading());
    try {
      final artists = await artistService.querySearch(event.query);
      final songs = await songService.searchSong(event.query);
      emit(SearchSuccess(artists, songs));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
