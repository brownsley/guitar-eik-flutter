import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/album_model.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/service/album_service.dart';
import 'package:guitar_eik/service/artist_service.dart';
import 'package:guitar_eik/service/song_service.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ArtistService artistService = ArtistService();
  final SongService songService = SongService();
  final AlbumService albumService = AlbumService();
  SearchBloc() : super(SearchInitial()) {
    on<OnQueryChanged>(
      _onSearch,
      transformer: (events, mapper) {
        return events
            .debounceTime(Duration(microseconds: 1000))
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
      final artists = await artistService.searchArtist(event.query);
      final songs = await songService.searchSong(event.query);
      final albums = await albumService.searchAlbum(event.query);
      emit(SearchSuccess(artists, songs, albums));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
