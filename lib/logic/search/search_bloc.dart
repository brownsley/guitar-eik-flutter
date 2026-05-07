import 'package:bloc/bloc.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/service/artist_service.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ArtistService artistService = ArtistService();
  SearchBloc() : super(SearchInitial()) {
    on<OnQueryChanged>(
      _onSearch,
      transformer: (events, mapper) {
        return events
            .debounceTime(Duration(microseconds: 50))
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
      final results = await artistService.querySearch(event.query);
      emit(SearchSuccess(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
