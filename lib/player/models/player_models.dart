import 'dart:typed_data';

class AudioMetaData {
  String filePath;
  String fileName;
  String fileFolder;
  Uint8List? image;
  String? title;
  Duration songDuration;

  AudioMetaData({required this.filePath, required this.fileName, required this.fileFolder, this.image, this.title, required this.songDuration});
}
