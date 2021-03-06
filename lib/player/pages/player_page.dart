import 'package:blur/blur.dart';
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
    } else {
      _playerCubit.play();
    }
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PlayerCubit, PlayerCubitState>(
            bloc: _playerCubit,
            buildWhen: (pState, state) {
              if (pState.title != state.title || pState.subTitle != state.subTitle || pState.image != state.image) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Blur(
                      blur: 60,
                      blurColor: Colors.grey.shade900,
                      colorOpacity: 0.8,
                      child: state.image != null ? SizedBox.expand(child: Image.memory(state.image!, fit: BoxFit.cover, height: 200, width: 200)) : SizedBox(height: double.infinity, child: Image.asset("image/default_song_image.jpg", fit: BoxFit.cover, height: 200, width: 200)),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
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
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 6,
                        fit: FlexFit.loose,
                        child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                          bloc: _playerCubit,
                          buildWhen: (pState, state) {
                            if (pState.image != state.image || pState.isPlaying != state.isPlaying) {
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
                                border: NeumorphicBorder(color: state.isPlaying ? Colors.deepOrangeAccent : Colors.blue, width: 2.0, isEnabled: true),
                                depth: state.isPlaying ? 9 : 5,
                                shadowLightColor: state.isPlaying ? Colors.orange : Colors.blue,
                                shadowDarkColor: state.isPlaying ? Colors.deepOrange : Colors.blue,
                                boxShape: const NeumorphicBoxShape.circle(),
                                shape: NeumorphicShape.convex,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 55,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: double.infinity),
                                    Text(
                                      state.title ?? convertSongFileNameToSongName(state.subTitle),
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    Text(
                                      state.subTitle,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.white54, size: 27.0),
                              padding: const EdgeInsets.all(0),
                              constraints: const BoxConstraints.tightFor(width: 27.0, height: 27.0),
                              onPressed: () {
                                // TODO
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                          bloc: _playerCubit,
                          buildWhen: (pState, state) {
                            if (pState.currentDuration != state.currentDuration || pState.songDuration != state.songDuration) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(trackShape: CustomTrackShape()),
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
                                Row(
                                  children: [
                                    Text(
                                      convertDurationToMinute1(state.currentDuration),
                                      style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 11),
                                    ),
                                    const Spacer(),
                                    Text(
                                      convertDurationToMinute1(state.songDuration),
                                      style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w600, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.loose,
                        child: BlocBuilder<PlayerCubit, PlayerCubitState>(
                          bloc: _playerCubit,
                          buildWhen: (pState, state) {
                            if (pState.isPlaying != state.isPlaying || pState.isShuffleMode != state.isShuffleMode || pState.isLoopModeOne != state.isLoopModeOne) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.repeat_one, color: state.isLoopModeOne ? Colors.deepOrange : Colors.white24),
                                  onPressed: () {
                                    if (state.isLoopModeOne) {
                                      _playerCubit.loopModeOne(false);
                                    } else {
                                      _playerCubit.loopModeOne(true);
                                    }
                                  },
                                ),
                                const SizedBox(width: 10),
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
                                      if (pState.isPlaying != state.isPlaying) {
                                        return true;
                                      }
                                      return false;
                                    },
                                    builder: (context, state) {
                                      if (state.isPlaying) {
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
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.shuffle, color: state.isShuffleMode ? Colors.deepOrange : Colors.white24),
                                  onPressed: () {
                                    if (state.isShuffleMode) {
                                      _playerCubit.shuffleMode(false);
                                    } else {
                                      _playerCubit.shuffleMode(true);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
