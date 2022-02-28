import 'package:flutter/material.dart';

import 'mfw_colors.dart';

// --------------------------------------------------------------------------------------------------------------------

// My DropDown widget:

class MDropDown extends StatefulWidget {
  final String initValue;
  final List<String> items;
  final double elevation;
  final double borderRadius;
  final IconData icon;
  final DropDownTheme dropDownTheme;
  final MDropDownOnChange onChange;

  const MDropDown({
    Key? key,
    required this.initValue,
    required this.items,
    this.elevation = 10.0,
    this.borderRadius = 10.0,
    this.icon = Icons.expand_more,
    this.dropDownTheme = DropDownTheme.light,
    required this.onChange,
  }) : super(key: key);

  @override
  State<MDropDown> createState() => _MDropDownState();
}

class _MDropDownState extends State<MDropDown> {
  String? dropdownValue;
  late Color backgroundColor;
  late Color dropdownColor;
  late TextStyle hintStyle;
  late Icon icon;
  late TextStyle style;

  @override
  Widget build(BuildContext context) {
    switch (widget.dropDownTheme) {
      case DropDownTheme.light:
        backgroundColor = Colors.white;
        dropdownColor = Colors.white;
        hintStyle = const TextStyle(color: MColors.blueGrey900, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        icon = Icon(widget.icon, color: MColors.blueGrey900, size: 15);
        style = const TextStyle(color: MColors.blueGrey900, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        break;

      case DropDownTheme.dark:
        backgroundColor = MColors.blueGrey900;
        dropdownColor = MColors.blueGrey900;
        hintStyle = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        icon = Icon(widget.icon, color: Colors.white, size: 15);
        style = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        break;

      case DropDownTheme.blue:
        backgroundColor = Colors.blue;
        dropdownColor = Colors.blue;
        hintStyle = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        icon = Icon(widget.icon, color: Colors.white, size: 15);
        style = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        break;

      case DropDownTheme.red:
        backgroundColor = Colors.red;
        dropdownColor = Colors.red;
        hintStyle = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        icon = Icon(widget.icon, color: Colors.white, size: 15);
        style = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        break;

      case DropDownTheme.green:
        backgroundColor = Colors.green;
        dropdownColor = Colors.green;
        hintStyle = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        icon = Icon(widget.icon, color: Colors.white, size: 15);
        style = const TextStyle(color: Colors.white, fontFamily: "IranSans", fontSize: 15, fontWeight: FontWeight.w400);
        break;
    }

    return Card(
      elevation: widget.elevation,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius)),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            style: style,
            icon: icon,
            hint: Text(widget.initValue, style: hintStyle),
            elevation: widget.elevation.round(),
            dropdownColor: dropdownColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                widget.onChange(newValue);
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

typedef MDropDownOnChange = void Function(String selectedItem);

enum DropDownTheme { light, dark, blue, red, green }

// --------------------------------------------------------------------------------------------------------------------

/*

// main package: https://pub.dev/packages/flutter_dropdown

// custom flutter dropdown widget:

class MDropDown<T> extends StatefulWidget {
  final List<T> items;
  final TextStyle itemsStyle;
  final Widget? hint;
  final Widget? icon;
  final Color dropDownPopopColor;
  final Function(T?)? onChanged;
  final T? initialValue;
  final List<Widget>? customWidgets;
  final bool isExpanded;
  final bool isCleared;

  const MDropDown({
    Key? key,
    required this.items,
    this.itemsStyle = const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
    this.hint = const Text("منوی انتخاب", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
    this.icon = const Icon(Icons.expand_more, color: Colors.black),
    this.dropDownPopopColor = Colors.grey,
    this.onChanged,
    this.initialValue,
    this.customWidgets,
    this.isExpanded = false,
    this.isCleared = false,
  })  : assert(items is! Widget),
        assert((customWidgets != null) ? items.length == customWidgets.length : (customWidgets == null)),
        super(key: key);

  @override
  _MDropDownState<T> createState() => _MDropDownState<T>();
}

class _MDropDownState<T> extends State<MDropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        isExpanded: widget.isExpanded,
        onChanged: (T? value) {
          setState(() => selectedValue = value);
          widget.onChanged?.call(value);
        },
        value: widget.isCleared ? null : selectedValue,
        items: widget.items.map<DropdownMenuItem<T>>((item) => buildDropDownItem(item)).toList(),
        hint: widget.hint,
        icon: widget.icon,
        dropdownColor: widget.dropDownPopopColor,
      ),
    );
  }

  DropdownMenuItem<T> buildDropDownItem(T item) => DropdownMenuItem<T>(
    child: (widget.customWidgets != null) ? widget.customWidgets![widget.items.indexOf(item)] : Text(item.toString(), style: widget.itemsStyle),
    value: item,
  );
}

*/
