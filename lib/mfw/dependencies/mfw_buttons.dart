import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// My button widget with gradient background and elevation:

typedef GradientButtonOnPressed = void Function();

class MGradientButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color splashColor;
  final GradientButtonOnPressed? elevatedGradientButtonOnPressed;
  final double elevation;
  final double width;
  final double height;
  final double borderRadius;
  final List<Color> colors;

  const MGradientButton({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(color: Colors.white),
    this.splashColor = Colors.white,
    this.elevation = 6.0,
    this.width = 50.0,
    this.height = 100.0,
    this.borderRadius = 35.0,
    this.colors = const [Colors.lightBlueAccent, Colors.blue, Colors.blueAccent],
    this.elevatedGradientButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      elevation: elevation,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: LinearGradient(colors: colors),
                ),
              ),
            ),
            Positioned.fill(
              child: TextButton(
                  style: TextButton.styleFrom(
                    primary: splashColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                  ),
                  child: Text(text, style: textStyle),
                  onPressed: elevatedGradientButtonOnPressed),
            )
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------------------------------------------------
