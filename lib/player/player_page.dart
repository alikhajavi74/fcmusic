import 'dart:typed_data';

import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/player_page_manager.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:marquee/marquee.dart';

class PlayerPage extends StatefulWidget {
  final String path;
  final String? name;
  final Uint8List? image;
  final String? title;

  const PlayerPage({Key? key, required this.path, required this.name, required this.image, required this.title}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late PlayerPageManager _pageManager;

  @override
  void initState() {
    _pageManager = PlayerPageManager(path: widget.path);
    super.initState();
  }

  @override
  void dispose() {
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
    var image = Flexible(
      flex: 6,
      fit: FlexFit.loose,
      child: ValueListenableBuilder<ButtonState>(
        valueListenable: _pageManager.buttonStateValueNotifier,
        builder: (context, value, child) {
          return Neumorphic(
            child: widget.image != null
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.dstATop),
                    child: Image.memory(
                      widget.image!,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.dstATop),
                    child: Image.asset(
                      "image/default_image_player.jpg",
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
            style: NeumorphicStyle(
              border: NeumorphicBorder(color: value == ButtonState.playing ? Colors.deepOrangeAccent : Colors.blue, width: 2.0, isEnabled: true),
              depth: value == ButtonState.playing ? 9 : 5,
              shadowLightColor: value == ButtonState.playing ? Colors.orange : Colors.blue,
              shadowDarkColor: value == ButtonState.playing ? Colors.deepOrange : Colors.blue,
              boxShape: const NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.convex,
            ),
          );
        },
      ),
    );
    var title = Text(
      widget.title ?? "Unknown",
      textAlign: TextAlign.center,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 17,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
    );
    var subTitle = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 20,
      child: Marquee(
        text: widget.name ?? "",
        blankSpace: 60,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.0,
        ),
      ),
    );
    var slider = ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressBarStateValueNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    convertDurationToMinute(value.current),
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    convertDurationToMinute(value.total),
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              SliderTheme(
                data: SliderThemeData(overlayShape: SliderComponentShape.noThumb),
                child: Slider(
                  value: value.current.inMilliseconds.toDouble(),
                  max: value.total.inMilliseconds.toDouble(),
                  activeColor: Colors.deepOrange,
                  thumbColor: Colors.deepOrange,
                  inactiveColor: Colors.white54,
                  onChanged: (double newValue) {
                    _pageManager.seek(Duration(milliseconds: newValue.toInt()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    var playAndNextAndPreviusButtons = Flexible(
      flex: 3,
      fit: FlexFit.loose,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(2.0),
            child: NeumorphicButton(
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
          ),
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.all(5.0),
            child: ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.buttonStateValueNotifier,
              builder: (context, value, child) {
                if (value == ButtonState.playing) {
                  return NeumorphicButton(
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
                return NeumorphicButton(
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
              },
            ),
          ),
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(2.0),
            child: NeumorphicButton(
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
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar,
            const Spacer(),
            image,
            const SizedBox(height: 30.0),
            title,
            const SizedBox(height: 20.0),
            subTitle,
            const SizedBox(height: 20.0),
            slider,
            const SizedBox(height: 20.0),
            playAndNextAndPreviusButtons,
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
