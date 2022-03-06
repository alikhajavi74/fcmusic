package ir.faracodeteam.test_place_flutter;

import android.util.Log;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class ScanSongs {
  String rootPath;
  List<File> songList;

  ScanSongs(String rootPath) {
    this.songList = new ArrayList<>();
    this.rootPath = rootPath;
    startScan();
  }

  private void startScan() {
    File rootFile = new File(rootPath);
    Log.i("MTest", "root length: " + rootFile.listFiles().length);
    for (File file : rootFile.listFiles()) {
      if (file != null && file.isDirectory()) {
        checkDirectory(file);
      } else if (file != null && file.isFile()) {
        checkFile(file);
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
    if (file.getName().endsWith(".mp3")) {
      songList.add(file);
    }
  }

}
