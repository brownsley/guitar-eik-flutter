part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Artist> artists;
  SearchSuccess(this.artists);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
