import 'package:fcmusic/toplevels.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroCubit extends Cubit<IntroCubitState> {
  final MethodChannel methodChannel = const MethodChannel(songsMethodChannelName);
  late ConcatenatingAudioSource concatedAllSongs;

  IntroCubit() : super(IntroCubitState.unknown);

  Future<void> init() async {
    List? songs = await methodChannel.invokeMethod(songsMethodName) as List?;
    if (songs == null || songs.isEmpty) {
      emit(IntroCubitState.notAccessToStorage);
    } else {
      concatedAllSongs = concatSongs(songs);
      await Future.delayed(const Duration(seconds: 3));
      emit(IntroCubitState.readySongs);
    }
  }

  Future<void> sendRequestAccessStorage() async {
    int versian = await methodChannel.invokeMethod(androidVersionMethodName);
    if (versian >= 30) {
      await Permission.manageExternalStorage.request();
      init();
    } else {
      await Permission.storage.request();
      init();
    }
  }
}

enum IntroCubitState {
  readySongs,
  notAccessToStorage,
  unknown,
}
