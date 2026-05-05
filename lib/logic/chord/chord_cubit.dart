import 'package:guitar_eik/model/song_model.dart';
import 'package:guitar_eik/service/song_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'chord_state.dart';

class ChordCubit extends Cubit<ChordState> {
  final SongService _songService = SongService();
  ChordCubit() : super(ChordInitial());

  void load(int id) async {
    emit(ChordLoading());
    final Song song = await _songService.getSongDetail(id);
    emit(ChordLoaded(song: song, isScrolling: false, transpose: 0, speed: 15));
  }

  void toggleScroll() {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      emit(currentState.copyWith(isScrolling: !currentState.isScrolling));
    }
  }

  void updateSpeed(int newSpeed) {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      emit(currentState.copyWith(speed: newSpeed));
    }
  }

  void addSpeed() {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      if (currentState.speed < 30) {
        emit(currentState.copyWith(speed: currentState.speed + 3));
      }
    }
  }

  void removeSpeed() {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      if (currentState.speed > 3) {
        emit(currentState.copyWith(speed: currentState.speed - 3));
      }
    }
  }

  void resetTranspose() {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      emit(currentState.copyWith(transpose: 0));
    }
  }

  void updateTranspose(int value) {
    if (state is ChordLoaded) {
      final currentState = state as ChordLoaded;
      int newTranspose = currentState.transpose + value;
      if (newTranspose >= -6 && newTranspose <= 6) {
        emit(currentState.copyWith(transpose: newTranspose));
      }
    }
  }
}
