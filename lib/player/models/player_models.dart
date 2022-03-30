import 'dart:typed_data';

import 'package:just_audio_background/just_audio_background.dart';

class AudioMetaData extends MediaItem {
  @override
  String id;

  @override
  String title;

  String filePath;
  String fileName;
  String fileFolder;
  Uint8List? image;
  Duration songDuration;

  AudioMetaData({required this.id, required this.title, required this.filePath, required this.fileName, required this.fileFolder, this.image, required this.songDuration}) : super(id: id, title: title);
}
