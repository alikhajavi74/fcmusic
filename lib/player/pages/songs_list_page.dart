import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/bloc/player_cubit.dart';
import 'package:fcmusic/player/models/player_models.dart';
import 'package:fcmusic/player/pages/player_page.dart';
import 'package:fcmusic/toplevels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class SongsListPage extends StatelessWidget {
  const SongsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConcatenatingAudioSource concatedSongs = context.read<PlayerCubit>().concatenatingAudioSource;
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: concatedSongs.length,
          itemBuilder: (context, position) {
            return SongListTile(position: position, indexedAudioSource: concatedSongs.sequence[position]);
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
    AudioMetaData songTag = widget.indexedAudioSource.tag as AudioMetaData;
    var image = Neumorphic(
      style: const NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 6.0,
        shadowLightColor: Colors.white38,
        shadowDarkColor: Colors.black87,
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
                )),
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
