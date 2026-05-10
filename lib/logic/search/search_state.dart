part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Artist> artists;
  final List<Song> songs;
  final List<Album> albums;
  SearchSuccess(this.artists, this.songs, this.albums);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
