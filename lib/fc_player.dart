import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class FCPlayer {
  late AudioPlayer _audioPlayer;

  final progressBarStateValueNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  final buttonStateValueNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  FCPlayer() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setAsset("audio/Roy Jones - Can't be touched-320k.mp3");

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        buttonStateValueNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonStateValueNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonStateValueNotifier.value = ButtonState.playing;
      } else {
        // completed
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    Stream<ProgressBarState> combinedStream = Rx.combineLatest3<Duration, Duration, Duration?, ProgressBarState>(
      _audioPlayer.positionStream,
      _audioPlayer.bufferedPositionStream,
      _audioPlayer.durationStream,
      (Duration currentPosition, Duration bufferedPosition, Duration? totalDuration) {
        return ProgressBarState(
          current: currentPosition,
          buffered: bufferedPosition,
          total: totalDuration ?? Duration.zero,
        );
      },
    );

    combinedStream.listen((newProgressBarState) {
      progressBarStateValueNotifier.value = newProgressBarState;
    });
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
}

enum ButtonState { paused, playing, loading }
