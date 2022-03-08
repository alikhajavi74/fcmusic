import 'package:fcmusic/home/song_list_tile.dart';
import 'package:fcmusic/toplevels.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: songsMethodChannel.invokeMethod("getSongs"),
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
                          int versian = await songsMethodChannel.invokeMethod("getAndroidVersion");
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
                    return SongListTile(song: songs[position]);
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
