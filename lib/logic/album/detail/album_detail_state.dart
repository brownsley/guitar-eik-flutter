part of 'album_detail_cubit.dart';

@immutable
sealed class AlbumDetailState {}

final class AlbumDetailInitial extends AlbumDetailState {}

final class AlbumDetailLoading extends AlbumDetailState {}

final class AlbumDetailError extends AlbumDetailState {
  final String message;
  AlbumDetailError(this.message);
}

final class AlbumDetailLoaded extends AlbumDetailState {
  final AlbumDetail album;
  AlbumDetailLoaded({required this.album});
}
