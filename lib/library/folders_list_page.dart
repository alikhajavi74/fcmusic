import 'package:fcmusic/intro/bloc/intro_cubit.dart';
import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/pages/songs_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class FoldersListPage extends StatefulWidget {
  final Map<String, ConcatenatingAudioSource> concatedFoldersSongs;

  const FoldersListPage({Key? key, required this.concatedFoldersSongs}) : super(key: key);

  @override
  State<FoldersListPage> createState() => _FoldersListPageState();
}

class _FoldersListPageState extends State<FoldersListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Folders", style: TextStyle(color: Colors.white54)), backgroundColor: Colors.black54),
        body: ListView(
          shrinkWrap: true,
          children: [
            for (String key in widget.concatedFoldersSongs.keys)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.folder, color: Colors.white54),
                    title: Text(key, style: const TextStyle(color: Colors.white54)),
                    trailing: const Icon(Icons.arrow_right, color: Colors.white54),
                    onTap: () {
                      goAnotherRoute(context, SongsListPage(concatedSongs: context.read<IntroCubit>().concatedFoldersSongs[key]!));
                    },
                  ),
                  const Divider(color: Colors.white24),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
