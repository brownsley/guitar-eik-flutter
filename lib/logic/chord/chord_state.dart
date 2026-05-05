part of 'chord_cubit.dart';

@immutable
sealed class ChordState {}

class ChordInitial extends ChordState {}

class ChordLoading extends ChordState {}

class ChordError extends ChordState {
  final String message;
  ChordError(this.message);
}

class ChordLoaded extends ChordState {
  final Song song;
  final bool isScrolling;
  final int transpose;
  final int speed;

  ChordLoaded({
    required this.song,
    required this.isScrolling,
    required this.transpose,
    required this.speed,
  });

  ChordLoaded copyWith({
    String? lyric,
    bool? isScrolling,
    int? transpose,
    int? speed,
  }) {
    return ChordLoaded(
      song: song,
      isScrolling: isScrolling ?? this.isScrolling,
      transpose: transpose ?? this.transpose,
      speed: speed ?? this.speed,
    );
  }
}
