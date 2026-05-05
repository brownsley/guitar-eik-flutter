part of 'song_cubit.dart';

@immutable
sealed class SongState {}

final class SongInitial extends SongState {}

final class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final List<Song> songs;
  SongLoaded(this.songs);
}

class SongError extends SongState {
  final String message;
  SongError(this.message);
}
