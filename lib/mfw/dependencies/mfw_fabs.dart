// PubDev main package: https://pub.dev/packages/flutter_text_field_fab

import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// My search fab widget:

class MSearchFAB extends StatefulWidget {
  // The placeholder label
  final String label;

  // The icon to be used on the FAB
  final IconData icon;

  // The background color of the FAB
  final Color backgroundColor;

  // The color of the icon on the FAB
  final Color iconColor;

  // A callback function for each time there is a change to the TextField's text
  final void Function(String) onChange;

  // A function to handle operations that need to be performed when the TextField is cleared or closed
  final Function onClear;

  const MSearchFAB({Key? key, required this.onChange, required this.onClear, this.label = "جستجو", this.icon = Icons.search, this.backgroundColor = Colors.blue, this.iconColor = Colors.white}) : super(key: key);

  @override
  _MSearchFABState createState() => _MSearchFABState();
}

class _MSearchFABState extends State<MSearchFAB> {
  late String label;
  late IconData icon;
  late Color backgroundColor;
  late Color iconColor;
  late void Function(String) onChange;
  late Function onClear;

  bool folded = true;

  // this.label, this.icon, {required this.onChange, required this.onSubmit, required this.onClear, this.backgroundColor = Colors.white, this.iconColor = Colors.black}

  @override
  void initState() {
    super.initState();
    label = widget.label;
    icon = widget.icon;
    backgroundColor = widget.backgroundColor;
    iconColor = widget.iconColor;
    onChange = widget.onChange;
    onClear = widget.onClear;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: folded ? 56 : MediaQuery.of(context).size.width / 1.5,
              height: 56,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: backgroundColor, boxShadow: kElevationToShadow[6]),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: !folded
                              ? TextField(
                                  style: TextStyle(color: iconColor),
                                  decoration: InputDecoration(contentPadding: const EdgeInsets.all(10.0), hintText: label, hintStyle: TextStyle(color: iconColor), border: InputBorder.none),
                                  onChanged: (String query) => onChange(query),
                                )
                              : null)),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(folded ? 35.0 : 0),
                        topRight: const Radius.circular(35.0),
                        bottomLeft: Radius.circular(folded ? 35.0 : 0),
                        bottomRight: const Radius.circular(35.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          folded ? icon : Icons.close,
                          color: iconColor,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (!folded) onClear();
                          folded = !folded;
                        });
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------------------------------------------------
