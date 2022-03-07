package ir.faracodeteam.fcmusic;

import android.media.MediaMetadataRetriever;
import android.os.Build;
import android.os.Environment;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

  public static final String METHOD_CHANNEL = "ir.faracodeteam.fcmusic/songs";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getSongs")) {
          try {
            List<HashMap<Object, Object>> finalSongsList = getSongs();
            result.success(finalSongsList);
          } catch (Exception e) {
            e.printStackTrace();
          }
        } else if (call.method.equals("getAndroidVersion")) {
          result.success(Build.VERSION.SDK_INT);
        } else {
          result.notImplemented();
        }
      }
    });
  }

  private List<HashMap<Object, Object>> getSongs() {
    ScanSongs scanSongs = new ScanSongs(getRootPath());
    List<HashMap<Object, Object>> list = new ArrayList<>();
    for (File songMP3File : scanSongs.songsMP3Files) {
      HashMap<Object, Object> map = new HashMap<>();
      map.put("file_path", songMP3File.getAbsolutePath());
      map.put("file_name", songMP3File.getName());
      MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
      mediaMetadataRetriever.setDataSource(songMP3File.getAbsolutePath());
      map.put("image", mediaMetadataRetriever.getEmbeddedPicture());
      map.put("title", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE));
      map.put("writer", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_WRITER));
      map.put("author", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_AUTHOR));
      map.put("album", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM));
      map.put("album_artist", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUMARTIST));
      map.put("location", mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_LOCATION));
      list.add(map);
    }
    return list;
  }

  private String getRootPath() {
    if (Build.VERSION.SDK_INT >= 30) {
      String[] splittedPath = getApplicationContext().getExternalFilesDir(null).getAbsolutePath().split("/");
      StringBuilder stringBuilder = new StringBuilder();
      for (String item : splittedPath) {
        if (item.equals("Android")) {
          break;
        }
        stringBuilder.append(item).append("/");
      }
      return stringBuilder.toString();
    }
    return Environment.getExternalStorageDirectory().getAbsolutePath();
  }
}
