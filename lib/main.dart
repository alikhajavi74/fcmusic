import 'package:fcmusic/back_end.dart';
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
        const SizedBox(width: 10, height: 60),
        NeumorphicButton(
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white54, size: 20),
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
          child: const Icon(Icons.menu, color: Colors.white54, size: 18),
          style: const NeumorphicStyle(
            color: Colors.black54,
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          onPressed: () {
            // TODO
          },
        ),
        const SizedBox(width: 10, height: 60),
      ],
    );
    var image = Neumorphic(
      child: Image.asset(
        "image/music_cover.jpg",
        width: 250,
        height: 250,
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
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    "${value.total.inSeconds.toDouble()}",
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
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
              onChangeEnd: (newValue) {
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
        child: Column(
          children: [
            appBar,
            const Spacer(flex: 2),
            image,
            const Spacer(flex: 2),
            const SizedBox(height: 5.0),
            title,
            const SizedBox(height: 15.0),
            subTitle,
            const Spacer(flex: 2),
            slider,
            const Spacer(flex: 2),
            playAndNextAndPreviusButtons,
            const SizedBox(height: 45.0),
          ],
        ),
      ),
    );
  }
}
