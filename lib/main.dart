import 'package:fcmusic/player/bloc/player_cubit.dart';
import 'package:fcmusic/player/pages/songs_list_page.dart';
import 'package:fcmusic/toplevels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>(
          lazy: false,
          create: (context) => PlayerCubit(concatenatingAudioSource: ConcatenatingAudioSource(children: [])),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
                return Center(
                  child: ElevatedButton(
                    child: const Text("مشاهده تمامی آهنگ ها"),
                    onPressed: () async {
                      await context.read<PlayerCubit>().changePlayList(concatSongs(songs));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const SongsListPage();
                      }));
                    },
                  ),
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
