import 'package:fcmusic/back_end.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _player;
  late PageManager _pageManager;

  @override
  void initState() {
    _player = AudioPlayer();
    _pageManager = PageManager();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = Row(
      children: [
        NeumorphicButton(
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_rounded, color: Colors.white54, size: 18),
          ),
          style: const NeumorphicStyle(
            color: Colors.black54,
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          onPressed: () {
            // TODO
          },
        ),
        const Spacer(),
        const Text("PLAYING NOW", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
        const Spacer(),
        NeumorphicButton(
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.menu, color: Colors.white54, size: 18),
          ),
          style: const NeumorphicStyle(
            color: Colors.black54,
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          onPressed: () {
            // TODO
          },
        ),
      ],
    );
    var image = Neumorphic(
      child: Image.asset(
        "image/music_cover.jpg",
        width: 300,
        height: 300,
      ),
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        shape: NeumorphicShape.flat,
      ),
    );
    var title = const Text(
      "Your Title",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white54,
        fontSize: 17,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
    );
    var subTitle = const Text(
      "Dj Snake Ft ALi",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white54,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 4.0,
      ),
    );
    var slider = ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "${value.current.inSeconds.toDouble()}",
                    style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  Spacer(),
                  Text(
                    "${value.total.inSeconds.toDouble()}",
                    style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
            NeumorphicSlider(
              value: value.current.inSeconds.toDouble(),
              max: value.total.inSeconds.toDouble(),
              style: const SliderStyle(
                depth: -20.0,
                border: NeumorphicBorder(
                  color: Colors.black54,
                ),
                accent: Colors.green,
              ),
              onChanged: (newValue) {
                _pageManager.seek(Duration(seconds: newValue.toInt()));
              },
            ),
          ],
        );
      },
    );
    var playAndNextAndPreviusButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NeumorphicButton(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(20.0),
          child: const Icon(
            Icons.skip_previous,
            color: Colors.white54,
            size: 20,
          ),
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.convex,
            color: Colors.black54,
          ),
          onPressed: () {
            // TODO
          },
        ),
        ValueListenableBuilder<ButtonState>(
          valueListenable: _pageManager.buttonNotifier,
          builder: (_, value, __) {
            switch (value) {
              case ButtonState.loading:
                return const CircularProgressIndicator();
              case ButtonState.paused:
                return NeumorphicButton(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(30.0),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white54,
                    size: 30,
                  ),
                  style: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex,
                    color: Colors.black54,
                  ),
                  onPressed: () async {
                    // TODO
                    _pageManager.play();
                  },
                );
              case ButtonState.playing:
                return NeumorphicButton(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(30.0),
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white54,
                    size: 30,
                  ),
                  style: NeumorphicStyle(
                    boxShape: const NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.concave,
                    color: Colors.deepOrange.shade800,
                  ),
                  onPressed: () async {
                    // TODO
                    _pageManager.pause();
                  },
                );
            }
          },
        ),
        NeumorphicButton(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(20.0),
          child: const Icon(
            Icons.skip_next,
            color: Colors.white54,
            size: 20,
          ),
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.convex,
            color: Colors.black54,
          ),
          onPressed: () {
            // TODO
          },
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            appBar,
            const SizedBox(height: 30),
            image,
            const SizedBox(height: 30),
            title,
            const SizedBox(height: 8.0),
            subTitle,
            const SizedBox(height: 40.0),
            slider,
            const SizedBox(height: 40),
            playAndNextAndPreviusButtons,
          ],
        ),
      ),
    );
  }
}
