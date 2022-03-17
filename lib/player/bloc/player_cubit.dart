import 'dart:typed_data';

import 'package:fcmusic/player/models/player_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class PlayerCubit extends Cubit<PlayerCubitState> {
  late AudioPlayer audioPlayer;
  late ConcatenatingAudioSource concatenatingAudioSource;

  PlayerCubit({required this.concatenatingAudioSource}) : super(PlayerCubitState.initState) {
    audioPlayer = AudioPlayer();
    init(concatenatingAudioSource);
  }

  Future<void> changePlayList(ConcatenatingAudioSource newConcatenatingAudioSource) async {
    concatenatingAudioSource = newConcatenatingAudioSource;
    audioPlayer.sequence?.clear();
    audioPlayer.sequence?.addAll(concatenatingAudioSource.sequence);
    await init(concatenatingAudioSource);
  }

  Future<void> init(ConcatenatingAudioSource concatenatingAudioSource) async {
    await audioPlayer.setAudioSource(concatenatingAudioSource);

    audioPlayer.playerStateStream.listen((PlayerState playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        emit(PlayerCubitState(
          state.image,
          state.title,
          state.subTitle,
          state.songDuration,
          state.currentDuration,
          PlayButtonState.notplaying,
        ));
      } else if (!isPlaying) {
        emit(PlayerCubitState(
          state.image,
          state.title,
          state.subTitle,
          state.songDuration,
          state.currentDuration,
          PlayButtonState.notplaying,
        ));
      } else if (processingState != ProcessingState.completed) {
        emit(PlayerCubitState(
          state.image,
          state.title,
          state.subTitle,
          state.songDuration,
          state.currentDuration,
          PlayButtonState.playing,
        ));
      } else {
        seekToIndext(0);
        pause();
      }
    });

    audioPlayer.positionStream.listen((Duration currentPosition) {
      emit(PlayerCubitState(
        state.image,
        state.title,
        state.subTitle,
        state.songDuration,
        currentPosition,
        state.playButtonState,
      ));
    });

    audioPlayer.sequenceStateStream.listen((SequenceState? sequenceState) {
      if (sequenceState != null) {
        if (audioPlayer.sequence != null && audioPlayer.sequence!.isNotEmpty) {
          AudioMetaData currentSongTag = audioPlayer.sequence![sequenceState.currentIndex].tag;
          emit(PlayerCubitState(
            currentSongTag.image,
            currentSongTag.title,
            currentSongTag.fileName,
            currentSongTag.songDuration,
            Duration.zero,
            audioPlayer.playing ? PlayButtonState.playing : PlayButtonState.notplaying,
          ));
        }
      }
    });
  }

  void play() {
    audioPlayer.play();
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
  }

  void seekToDuration(Duration duration) {
    audioPlayer.seek(duration);
  }

  void seekToIndext(int index) async {
    AudioMetaData newSongTag = audioPlayer.sequence![index].tag;
    emit(PlayerCubitState(
      newSongTag.image,
      newSongTag.title,
      newSongTag.fileName,
      newSongTag.songDuration,
      Duration.zero,
      PlayButtonState.playing,
    ));
    await audioPlayer.seek(Duration.zero, index: index);
    await audioPlayer.play();
  }

  void seekToNext() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
    } else {
      seekToIndext(0);
    }
  }

  void seekToPrevius() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
    } else {
      seekToIndext(concatenatingAudioSource.children.length - 1);
    }
  }

  void resetState() {
    emit(PlayerCubitState.initState);
  }

  void dispose() {
    audioPlayer.dispose();
  }
}

class PlayerCubitState {
  static PlayerCubitState initState = PlayerCubitState(
    null,
    "Title",
    "SubTitle",
    Duration.zero,
    Duration.zero,
    PlayButtonState.notplaying,
  );

  Uint8List? image;
  String? title;
  String subTitle;
  Duration songDuration;
  Duration currentDuration;
  PlayButtonState playButtonState;

  PlayerCubitState(this.image, this.title, this.subTitle, this.songDuration, this.currentDuration, this.playButtonState);
}

enum PlayButtonState {
  playing,
  notplaying,
}
