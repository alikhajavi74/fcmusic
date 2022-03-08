import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../mfw/dependencies/mfw_utils.dart';
import '../player/player_page.dart';

class SongListTile extends StatefulWidget {
  final dynamic song;

  const SongListTile({Key? key, required this.song}) : super(key: key);

  @override
  State<SongListTile> createState() => _SongListTileState();
}

class _SongListTileState extends State<SongListTile> {
  @override
  Widget build(BuildContext context) {
    var image = Hero(
      tag: "tag${widget.song["title"]}",
      child: Neumorphic(
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
            child: widget.song["image"] != null
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                    child: Image.memory(widget.song["image"], fit: BoxFit.cover),
                  )
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.60), BlendMode.dstATop),
                    child: Image.asset("image/default_image_player.jpg", fit: BoxFit.cover),
                  )),
      ),
    );
    var info = Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.song["title"] ?? "NoTitle", softWrap: false, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white70, letterSpacing: 2.0, fontSize: 15.0, fontWeight: FontWeight.w600)),
          Text(widget.song["file_name"] ?? "NoTitle", softWrap: false, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white54, letterSpacing: 1.0, fontSize: 13.0, fontWeight: FontWeight.w400)),
          Text("${convertDurationToMinute1(Duration(milliseconds: int.parse(widget.song["duration"])))} | mp3", softWrap: false, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white38, letterSpacing: 1.0, fontSize: 10.0, fontWeight: FontWeight.w400)),
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
          return PlayerPage(
            path: widget.song["file_path"],
            name: widget.song["file_name"],
            image: widget.song["image"],
            title: widget.song["title"],
          );
        }));
      },
    );
  }
}

/*ListTile(
      title: Text(widget.song["title"] ?? "NoTitle", softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14.0, color: Colors.white)),
      subtitle: Text(widget.song["file_name"] ?? "NoArtist", softWrap: false, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
      leading: Text("${convertDurationToMinute1(Duration(milliseconds: int.parse(widget.song["duration"])))} | mp3", style: const TextStyle(fontSize: 10.0, color: Colors.white)),
      trailing: widget.song["image"] != null ? ClipOval(child: Image.memory(widget.song["image"])) : ClipOval(child: Image.asset("image/default_image_player.jpg")),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return PlayerPage(
            path: widget.song["file_path"],
            name: widget.song["file_name"],
            image: widget.song["image"],
            title: widget.song["title"],
          );
        }));
      },
    )*/
