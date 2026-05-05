import 'package:guitar_eik/model/artist_detail_model.dart';
import 'package:guitar_eik/service/artist_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'artist_detail_state.dart';

class ArtistDetailCubit extends Cubit<ArtistDetailState> {
  final ArtistService _artistService = ArtistService();
  ArtistDetailCubit() : super(ArtistDetailInitial());
  Future<void> artistDetailLoad(int id) async {
    try {
      emit(ArtistDetailLoading());
      final response = await _artistService.getArtistDetail(id);
      emit(ArtistDetailLoaded(artistDetail: response));
    } catch (e) {
      emit(ArtistDetailError(error: e.toString()));
    }
  }
}
