part of 'artist_cubit.dart';

@immutable
sealed class ArtistState {}

final class ArtistInitial extends ArtistState {}

final class ArtistLoading extends ArtistState {}

final class ArtistLoaded extends ArtistState {
  final List<Artist> artists;
  final bool isLast;
  final int currentPage;
  ArtistLoaded({
    required this.artists,
    required this.isLast,
    this.currentPage = 0,
  });
}

final class ArtistError extends ArtistState {
  final String error;
  ArtistError({required this.error});
}
