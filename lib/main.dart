import 'package:fcmusic/folders_page.dart';
import 'package:fcmusic/intro/bloc/intro_cubit.dart';
import 'package:fcmusic/intro/pages/permision_page.dart';
import 'package:fcmusic/player/bloc/player_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

import 'intro/pages/splash_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>(
          lazy: false,
          create: (context) => PlayerCubit(concatenatingAudioSource: ConcatenatingAudioSource(children: [])),
        ),
        BlocProvider<IntroCubit>(
          lazy: false,
          create: (context) => IntroCubit()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<IntroCubit, IntroCubitState>(
          bloc: context.read<IntroCubit>(),
          builder: (BuildContext context, IntroCubitState state) {
            if (state == IntroCubitState.readySongs) {
              return const FoldersPage();
            } else if (state == IntroCubitState.notAccessToStorage) {
              return const PermisionPage();
            } else if (state == IntroCubitState.loadingSongs) {
              return const Center(
                child: SizedBox.square(
                  dimension: 30.0,
                  child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 1.5),
                ),
              );
            }
            return const SplashPage();
          },
        ),
      ),
    );
  }
}
