import 'package:fcmusic/player/models/player_models.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

const MethodChannel songsMethodChannel = MethodChannel("ir.faracodeteam.fcmusic/songs");

ConcatenatingAudioSource concatSongs(List songs) {
  ConcatenatingAudioSource concatenatingAudioSource = ConcatenatingAudioSource(children: []);
  for (var song in songs) {
    concatenatingAudioSource.add(
      AudioSource.uri(
        Uri.parse(song["file_path"]),
        tag: AudioMetaData(
          filePath: song["file_path"],
          fileName: song["file_name"],
          image: song["image"],
          title: song["title"],
          songDuration: Duration(milliseconds: int.parse(song["duration"])),
        ),
      ),
    );
  }
  return concatenatingAudioSource;
}

String convertSongFileNameToSongName(String fileName) {
  fileName = fileName.replaceAll(".mp3", "");
  if (fileName.contains("-")) {
    return fileName.split("-")[1].trim();
  } else if (fileName.contains("_")) {
    return fileName.split("_")[1].trim();
  } else if (fileName.contains(".")) {
    return fileName.split(".")[1].trim();
  } else {
    if (fileName.length > 20) {
      return fileName.substring(0, 20);
    }
    return fileName;
  }
}
