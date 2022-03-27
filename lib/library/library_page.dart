import 'package:fcmusic/intro/bloc/intro_cubit.dart';
import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/pages/songs_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'folders_list_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Library", style: TextStyle(color: Colors.white54)), backgroundColor: Colors.black54),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.all_inclusive, color: Colors.white54),
                title: const Text("All Songs", style: TextStyle(color: Colors.white54)),
                trailing: const Icon(Icons.arrow_right, color: Colors.white54),
                onTap: () {
                  goAnotherRoute(context, SongsListPage(concatedSongs: context.read<IntroCubit>().concatedAllSongs));
                },
              ),
              const Divider(color: Colors.white24),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.folder, color: Colors.white54),
                title: const Text("Folders", style: TextStyle(color: Colors.white54)),
                trailing: const Icon(Icons.arrow_right, color: Colors.white54),
                onTap: () {
                  goAnotherRoute(context, FoldersListPage(concatedFoldersSongs: context.read<IntroCubit>().concatedFoldersSongs));
                },
              ),
              const Divider(color: Colors.white24),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.playlist_play, color: Colors.white54),
                title: const Text("PlayLists", style: TextStyle(color: Colors.white54)),
                trailing: const Icon(Icons.arrow_right, color: Colors.white54),
                onTap: () {
                  // TODO
                },
              ),
              const Divider(color: Colors.white24),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.white54),
                title: const Text("Favorite", style: TextStyle(color: Colors.white54)),
                trailing: const Icon(Icons.arrow_right, color: Colors.white54),
                onTap: () {
                  // TODO
                },
              ),
              const Divider(color: Colors.white24),
            ],
          ),
        ],
      ),
    );
  }
}
