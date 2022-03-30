import 'package:blur/blur.dart';
import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/bloc/player_cubit.dart';
import 'package:fcmusic/player/models/player_models.dart';
import 'package:fcmusic/player/pages/player_page.dart';
import 'package:fcmusic/toplevels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class SongsListPage extends StatelessWidget {
  final ConcatenatingAudioSource concatedSongs;

  const SongsListPage({Key? key, required this.concatedSongs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PlayerCubit>().changePlayList(concatedSongs);
    PlayerCubit _playerCubit = context.read<PlayerCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PlayerCubit, PlayerCubitState>(
          bloc: _playerCubit,
          buildWhen: (pState, state) {
            if (pState.currentDuration != state.currentDuration || pState.songDuration != state.songDuration) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Blur(
                    blur: 60,
                    blurColor: Colors.grey.shade900,
                    colorOpacity: 0.8,
                    child: state.image != null ? SizedBox.expand(child: Image.memory(state.image!, fit: BoxFit.cover, height: 200, width: 200)) : SizedBox(height: double.infinity, child: Image.asset("image/default_song_image.jpg", fit: BoxFit.cover, height: 200, width: 200)),
                  ),
                ),
                ListView(
                  children: [for (int i = 0; i < concatedSongs.length; i++) SongListTile(position: i, indexedAudioSource: _playerCubit.concatenatingAudioSource.sequence[i])],
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      color: Colors.black87,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: state.image != null
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                                      child: Image.memory(state.image!, fit: BoxFit.cover),
                                    )
                                  : ColorFiltered(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                                      child: Image.asset("image/default_song_image.jpg", fit: BoxFit.cover),
                                    ),
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.title ?? state.subTitle, softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 5),
                                Text(state.subTitle, softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: state.isPlaying ? const Icon(Icons.pause, color: Colors.white, size: 25) : const Icon(Icons.play_arrow, color: Colors.white, size: 25),
                            padding: const EdgeInsets.only(right: 20, top: 5, bottom: 5),
                            onPressed: () {
                              if (_playerCubit.audioPlayer.playing) {
                                _playerCubit.pause();
                              } else {
                                _playerCubit.play();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return PlayerPage(songIndex: _playerCubit.audioPlayer.currentIndex ?? 0);
                    }));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SongListTile extends StatefulWidget {
  final int position;
  final IndexedAudioSource indexedAudioSource;

  const SongListTile({Key? key, required this.position, required this.indexedAudioSource}) : super(key: key);

  @override
  State<SongListTile> createState() => _SongListTileState();
}

class _SongListTileState extends State<SongListTile> {
  @override
  Widget build(BuildContext context) {
    PlayerCubit _playerCubit = context.read<PlayerCubit>();
    AudioMetaData songTag = widget.indexedAudioSource.tag as AudioMetaData;
    var image = Neumorphic(
      style: NeumorphicStyle(
        border: NeumorphicBorder(color: (widget.position == _playerCubit.audioPlayer.currentIndex) ? Colors.deepOrangeAccent : Colors.transparent, width: 1.0, isEnabled: true),
        depth: (widget.position == _playerCubit.audioPlayer.currentIndex) ? 9.0 : 6.0,
        shadowLightColor: (widget.position == _playerCubit.audioPlayer.currentIndex) ? Colors.orange : Colors.white38,
        shadowDarkColor: (widget.position == _playerCubit.audioPlayer.currentIndex) ? Colors.deepOrange : Colors.black87,
        shape: NeumorphicShape.convex,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: SizedBox(
        height: 120,
        width: 120,
        child: songTag.image != null
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                child: Image.memory(songTag.image!, fit: BoxFit.cover),
              )
            : ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                child: Image.asset("image/default_song_image.jpg", fit: BoxFit.cover),
              ),
      ),
    );
    var info = Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(songTag.title ?? convertSongFileNameToSongName(songTag.fileName), softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, letterSpacing: 2.0, fontSize: 15.0, fontWeight: FontWeight.w600)),
          Text(songTag.fileName, softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white54, letterSpacing: 1.0, fontSize: 13.0, fontWeight: FontWeight.w400)),
          Text("${convertDurationToMinute1(songTag.songDuration)} | mp3", softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white38, letterSpacing: 1.0, fontSize: 10.0, fontWeight: FontWeight.w400)),
        ],
      ),
    );
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        height: 100,
        child: Row(
          children: [
            image,
            const SizedBox(width: 15),
            info,
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return PlayerPage(songIndex: widget.position);
        }));
      },
    );
  }
}
