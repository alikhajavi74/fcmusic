import 'dart:typed_data';

class AudioMetaData {
  String filePath;
  String fileName;
  Uint8List? image;
  String? title;
  Duration songDuration;

  AudioMetaData({required this.filePath, required this.fileName, this.image, this.title, required this.songDuration});
}
