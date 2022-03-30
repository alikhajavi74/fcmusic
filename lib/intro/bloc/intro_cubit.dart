import 'package:fcmusic/toplevels.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroCubit extends Cubit<IntroCubitState> {
  final MethodChannel methodChannel = const MethodChannel(songsMethodChannelName);
  late ConcatenatingAudioSource concatedAllSongs;
  late Map<String, ConcatenatingAudioSource> concatedFoldersSongs;

  IntroCubit() : super(IntroCubitState.loadingSongs);

  Future<void> init() async {
    emit(IntroCubitState.loadingSongs);
    List? songs = await methodChannel.invokeMethod(songsMethodName) as List?;
    if (songs == null || songs.isEmpty) {
      emit(IntroCubitState.notAccessToStorage);
    } else {
      concatedAllSongs = concatAllSongs(songs);
      concatedFoldersSongs = concatFoldersSongs(songs);
      // await Future.delayed(const Duration(seconds: 1)); // No need
      emit(IntroCubitState.readySongs);
    }
  }

  Future<void> sendRequestAccessStorage() async {
    int versian = await methodChannel.invokeMethod(androidVersionMethodName);
    if (versian >= 30) {
      PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
      if (permissionStatus.isGranted) {
        init();
      } else {
        sendRequestAccessStorage();
      }
    } else {
      await Permission.storage.request();
      init();
    }
  }
}

enum IntroCubitState {
  readySongs,
  loadingSongs,
  notAccessToStorage,
  unknown,
}
