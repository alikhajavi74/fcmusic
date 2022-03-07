package ir.faracodeteam.fcmusic;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class ScanSongs {
  String rootPath;
  List<File> songsMP3Files;

  ScanSongs(String rootPath) {
    this.songsMP3Files = new ArrayList<>();
    this.rootPath = rootPath;
    startScan();
  }

  private void startScan() {
    File rootFile = new File(rootPath);
    if (rootFile.listFiles() != null) {
      for (File file : rootFile.listFiles()) {
        if (file != null && file.isDirectory()) {
          checkDirectory(file);
        } else if (file != null && file.isFile()) {
          checkFile(file);
        }
      }
    }
  }

  private void checkDirectory(File directory) {
    if (directory.listFiles() != null) {
      for (File file : directory.listFiles()) {
        if (file != null && file.isDirectory()) {
          checkDirectory(file);
        } else if (file != null && file.isFile()) {
          checkFile(file);
        }
      }
    }
  }

  private void checkFile(File file) {
    if (file != null && file.getName().endsWith(".mp3")) {
      songsMP3Files.add(file);
    }
  }
}
