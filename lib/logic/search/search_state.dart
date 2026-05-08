part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Artist> artists;
  final List<Song> songs;
  SearchSuccess(this.artists, this.songs);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
