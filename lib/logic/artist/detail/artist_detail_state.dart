part of 'artist_detail_cubit.dart';

@immutable
sealed class ArtistDetailState {}

final class ArtistDetailInitial extends ArtistDetailState {}

final class ArtistDetailLoading extends ArtistDetailState {}

final class ArtistDetailLoaded extends ArtistDetailState {
  final ArtistDetail artistDetail;
  ArtistDetailLoaded({required this.artistDetail});
}

final class ArtistDetailError extends ArtistDetailState {
  final String error;
  ArtistDetailError({required this.error});
}
