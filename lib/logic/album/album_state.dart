part of 'album_cubit.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitial extends AlbumState {}

final class AlbumLoading extends AlbumState {}

final class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final bool isLast;
  final int currentPage;
  AlbumLoaded({
    required this.albums,
    required this.isLast,
    this.currentPage = 0,
  });
}

final class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}
