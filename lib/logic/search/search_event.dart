part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class OnQueryChanged extends SearchEvent {
  final String query;
  OnQueryChanged(this.query);
}

class OnResetSearch extends SearchEvent {}
