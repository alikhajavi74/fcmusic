import 'package:fcmusic/player/player_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: "FC Music Player",
      theme: NeumorphicThemeData(
        baseColor: Colors.grey.shade900,
        depth: 6.0,
        intensity: 0.65,
        shadowLightColor: Colors.white38,
        shadowDarkColor: Colors.black87,
        accentColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MethodChannel _methodChannel = const MethodChannel("ir.faracodeteam.fcmusic/songs");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _methodChannel.invokeMethod("getSongs"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var songs = snapshot.data as List?;
              if (songs == null || songs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("لطفا ابتدا مجوز دسترسی را تایید کنید"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        child: const Text("تایید مجوز دسترسی"),
                        onPressed: () async {
                          int versian = await _methodChannel.invokeMethod("getAndroidVersion");
                          if (versian >= 30) {
                            await Permission.manageExternalStorage.request();
                          } else {
                            await Permission.storage.request();
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, position) {
                    return ListTile(
                      title: Text(songs[position]["title"] ?? "NoTitle", style: const TextStyle(color: Colors.white)),
                      subtitle: Text(songs[position]["file_name"] ?? "NoArtist", style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return PlayerPage(
                              path: songs[position]["file_path"],
                              name: songs[position]["file_name"],
                              image: songs[position]["image"],
                              title: songs[position]["title"],
                            );
                          }));
                        },
                      ),
                    );
                  },
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
