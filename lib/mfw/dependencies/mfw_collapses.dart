import 'package:flutter/material.dart';

import 'mfw_colors.dart';

// --------------------------------------------------------------------------------------------------------------------

// My CollapseText widget:

class CollapseText extends StatefulWidget {
  final String title;
  final String description;
  final bool expand;

  const CollapseText({Key? key, required this.title, required this.description, this.expand = false}) : super(key: key);

  @override
  _CollapseTextState createState() => _CollapseTextState();
}

class _CollapseTextState extends State<CollapseText> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expand;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _toogleExpand,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, size: 22.0, color: MColors.grey900),
              const SizedBox(width: 8.0),
              Expanded(child: Text(widget.title, style: const TextStyle(color: MColors.grey900, fontSize: 16.0, fontWeight: FontWeight.w500))),
            ],
          ),
        ),
        ExpandedSection(
          expand: _isExpanded,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            child: Text(widget.description, style: const TextStyle(color: MColors.grey600, fontSize: 14.0, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }

  // Toogle the box to expand or collapse
  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

// --------------------------------------------------------------------------------------------------------------------

// ExpandedSection Wiget:
// ReadMore: https://stackoverflow.com/questions/49029841/how-to-animate-collapse-elements-in-flutter

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  const ExpandedSection({Key? key, required this.expand, required this.child}) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }

  // Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    Animation<double> curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }
}

// --------------------------------------------------------------------------------------------------------------------
