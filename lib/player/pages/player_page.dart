import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/bloc/player_cubit.dart';
import 'package:fcmusic/toplevels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PlayerPage extends StatefulWidget {
  final int songIndex;

  const PlayerPage({Key? key, required this.songIndex}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late PlayerCubit _playerCubit;

  @override
  Widget build(BuildContext context) {
    _playerCubit = context.read<PlayerCubit>();
    if (widget.songIndex != _playerCubit.audioPlayer.currentIndex) {
      _playerCubit.seekToIndext(widget.songIndex);
    }
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
    var imageAndtitleAndSubTitle = BlocBuilder<PlayerCubit, PlayerCubitState>(
        bloc: _playerCubit,
        buildWhen: (pState, state) {
          if (pState.image != state.image || pState.title != state.title || pState.subTitle != state.subTitle) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 6,
                fit: FlexFit.loose,
                child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                  bloc: _playerCubit,
                  buildWhen: (pState, state) {
                    if (pState.image != state.image || pState.playButtonState != state.playButtonState) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return Neumorphic(
                      child: state.image != null
                          ? ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.dstATop),
                              child: Image.memory(
                                state.image!,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.dstATop),
                              child: Image.asset(
                                "image/default_song_image.jpg",
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(color: state.playButtonState == PlayButtonState.play ? Colors.deepOrangeAccent : Colors.blue, width: 2.0, isEnabled: true),
                        depth: state.playButtonState == PlayButtonState.play ? 9 : 5,
                        shadowLightColor: state.playButtonState == PlayButtonState.play ? Colors.orange : Colors.blue,
                        shadowDarkColor: state.playButtonState == PlayButtonState.play ? Colors.deepOrange : Colors.blue,
                        boxShape: const NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.convex,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 20,
                child: Text(
                  state.title ?? convertSongFileNameToSongName(state.subTitle),
                  textAlign: TextAlign.center,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 20,
                child: Text(
                  state.subTitle,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          );
        });
    var slider = BlocBuilder<PlayerCubit, PlayerCubitState>(
      bloc: _playerCubit,
      buildWhen: (pState, state) {
        if (pState.currentDuration != state.currentDuration || pState.songDuration != state.songDuration) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    convertDurationToMinute1(state.currentDuration),
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    convertDurationToMinute1(state.songDuration),
                    style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              SliderTheme(
                data: SliderThemeData(overlayShape: SliderComponentShape.noThumb),
                child: Slider(
                  value: state.currentDuration.inMilliseconds.toDouble(),
                  max: state.songDuration.inMilliseconds.toDouble(),
                  activeColor: Colors.deepOrange,
                  thumbColor: Colors.deepOrange,
                  inactiveColor: Colors.white54,
                  onChanged: (double newValue) {
                    _playerCubit.seekToDuration(Duration(milliseconds: newValue.toInt()));
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
                _playerCubit.seekToPrevius();
              },
            ),
          ),
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.all(5.0),
            child: BlocBuilder<PlayerCubit, PlayerCubitState>(
              bloc: _playerCubit,
              buildWhen: (pState, state) {
                if (pState.playButtonState != state.playButtonState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state.playButtonState == PlayButtonState.play) {
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
                      _playerCubit.pause();
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
                    _playerCubit.play();
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
                _playerCubit.seekToNext();
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
            imageAndtitleAndSubTitle,
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
