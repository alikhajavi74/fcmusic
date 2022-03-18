import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Neumorphic(
          child: Image.asset("image/default_song_image.jpg", width: 200, height: 200, fit: BoxFit.cover),
          style: const NeumorphicStyle(
            shadowLightColor: Colors.white54,
            shadowDarkColor: Colors.black87,
            depth: 6.0,
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
        ),
      ),
    );
  }
}
