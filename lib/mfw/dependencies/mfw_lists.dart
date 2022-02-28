// PubDev main package: https://pub.dev/packages/auto_animated
// Requirement Package: auto_animated: ^3.0.1

// import 'package:auto_animated/auto_animated.dart';
// import 'package:flutter/material.dart';

/*

// --------------------------------------------------------------------------------------------------------------------

// AnimatedList:

const animatedListGlobalOptions = LiveOptions(
  // Start animation after (default zero)
  delay: Duration.zero,
  // Show each item through (default 250)
  showItemInterval: Duration(milliseconds: 100),
  // Animation duration (default 250)
  showItemDuration: Duration(milliseconds: 100),
  // Animations starts at 0.05 visible
  // item fraction in sight (default 0.025)
  visibleFraction: 0.025,
  // Repeat the animation of the appearance
  // when scrolling in the opposite direction (default false)
  // To get the effect as in a showcase for ListView, set true
  reAnimateOnVisibility: false,
);

class MAnimatedList extends StatelessWidget {
  final LiveOptions options;
  final List<Widget> children;
  final Axis axis;

  const MAnimatedList({Key? key, this.options = animatedListGlobalOptions, required this.children, this.axis = Axis.vertical}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveList.options(
      options: options,
      itemBuilder: buildAnimatedItem,
      scrollDirection: axis,
      itemCount: children.length,
    );
  }

  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
        child: children[index],
      ),
    );
  }
}

// --------------------------------------------------------------------------------------------------------------------

*/
