part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Song> favoriteSongs;
  FavoriteLoaded(this.favoriteSongs);
}
