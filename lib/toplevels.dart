import 'package:fcmusic/player/models/player_models.dart';
import 'package:just_audio/just_audio.dart';

// Method channel info:
const String songsMethodChannelName = "ir.faracodeteam.fcmusic/songs";

const String songsMethodName = "getSongs";

const String androidVersionMethodName = "getAndroidVersion";

// Utilities functions:
ConcatenatingAudioSource concatAllSongs(List songs) {
  ConcatenatingAudioSource concatenatingAudioSource = ConcatenatingAudioSource(children: []);
  for (var song in songs) {
    concatenatingAudioSource.add(
      AudioSource.uri(
        Uri.parse(song["file_path"]),
        tag: AudioMetaData(
          id: song["id"],
          title: song["title"] ?? convertSongFileNameToSongName(song["file_name"]),
          filePath: song["file_path"],
          fileName: song["file_name"],
          fileFolder: song["file_folder"],
          image: song["image"],
          songDuration: Duration(milliseconds: int.parse(song["duration"])),
        ),
      ),
    );
  }
  return concatenatingAudioSource;
}

Map<String, ConcatenatingAudioSource> concatFoldersSongs(List songs) {
  Map<String, ConcatenatingAudioSource> concatedSongsOfFoldersMap = {};
  Set<String> foldersNameSet = {};
  for (var song in songs) {
    foldersNameSet.add(song["file_folder"]);
  }
  for (String folderName in foldersNameSet) {
    concatedSongsOfFoldersMap.addAll({folderName: ConcatenatingAudioSource(children: [])});
  }
  for (var song in songs) {
    String songFolderName = song["file_folder"] as String;
    concatedSongsOfFoldersMap[songFolderName]?.add(
      AudioSource.uri(
        Uri.parse(song["file_path"]),
        tag: AudioMetaData(
          id: song["id"],
          title: song["title"] ?? convertSongFileNameToSongName(song["file_name"]),
          filePath: song["file_path"],
          fileName: song["file_name"],
          fileFolder: song["file_folder"],
          image: song["image"],
          songDuration: Duration(milliseconds: int.parse(song["duration"])),
        ),
      ),
    );
  }
  return concatedSongsOfFoldersMap;
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
