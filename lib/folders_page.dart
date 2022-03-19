import 'package:fcmusic/intro/bloc/intro_cubit.dart';
import 'package:fcmusic/mfw/dependencies/mfw_utils.dart';
import 'package:fcmusic/player/pages/songs_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({Key? key}) : super(key: key);

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              for (String key in context.read<IntroCubit>().concatedFoldersSongs.keys)
                ListTile(
                  title: Text(key, style: const TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.folder, color: Colors.white),
                  onTap: () {
                    goAnotherRoute(context, SongsListPage(concatedSongs: context.read<IntroCubit>().concatedFoldersSongs[key]!));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
