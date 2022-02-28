import 'package:flutter/material.dart';

typedef MCheckBoxOnChange = void Function(bool newValue);

// --------------------------------------------------------------------------------------------------------------------

// My base CheckBox:

class MCheckBox extends StatefulWidget {
  final Color checkColor;
  final Color focusColor;
  final Color fillColor;
  final Widget widget;
  final MCheckBoxOnChange onChange;

  const MCheckBox({
    Key? key,
    this.checkColor = Colors.white,
    this.focusColor = Colors.black87,
    this.fillColor = Colors.black87,
    required this.widget,
    required this.onChange,
  }) : super(key: key);

  @override
  State<MCheckBox> createState() => _MCheckBoxState();
}

class _MCheckBoxState extends State<MCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20.0,
          height: 20.0,
          child: Checkbox(
            checkColor: widget.checkColor,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.onChange(value);
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: widget.widget),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return widget.focusColor;
    }
    return widget.fillColor;
  }
}

// --------------------------------------------------------------------------------------------------------------------

// My simple CheckBox:

class MSimpleCheckBox extends StatefulWidget {
  final Color checkColor;
  final Color focusColor;
  final Color fillColor;
  final String text;
  final MCheckBoxOnChange onChange;

  const MSimpleCheckBox({
    Key? key,
    this.checkColor = Colors.white,
    this.focusColor = Colors.black87,
    this.fillColor = Colors.black87,
    required this.text,
    required this.onChange,
  }) : super(key: key);

  @override
  State<MSimpleCheckBox> createState() => _MSimpleCheckBoxState();
}

class _MSimpleCheckBoxState extends State<MSimpleCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20.0,
          height: 20.0,
          child: Checkbox(
            checkColor: widget.checkColor,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.onChange(value);
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(widget.text, style: TextStyle(color: widget.fillColor, fontSize: 16.0, fontWeight: FontWeight.w500))),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return widget.focusColor;
    }
    return widget.fillColor;
  }
}

// --------------------------------------------------------------------------------------------------------------------
