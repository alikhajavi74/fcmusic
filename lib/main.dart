import 'package:fcmusic/home/home_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(const MyApp());
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
