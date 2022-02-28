import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// My gradient background widget:

class MGradientBackground extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final List<Color> gradientColors;
  final Widget? child;

  const MGradientBackground({
    Key? key,
    this.width,
    this.height,
    this.radius = 0,
    this.gradientColors = const [Colors.lightBlueAccent, Colors.blue, Colors.blueAccent],
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: child,
    );
  }
}

// --------------------------------------------------------------------------------------------------------------------
