import 'package:flutter/material.dart';

import 'mfw_colors.dart';

// --------------------------------------------------------------------------------------------------------------------

// My base rtl appbar:

AppBar mBaseRTLAppBar(BuildContext context, {Color backgroundColor = Colors.white, String? title, Color contentColor = MColors.blueGrey600, double elevation = 0.0, bool enableLeading = true, IconData leadingIcon = Icons.help, VoidCallback? leadingOnPressed}) {
  return AppBar(
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: false,
    title: title != null ? Text(title, style: TextStyle(color: contentColor, fontSize: 18.0, fontWeight: FontWeight.w500)) : null,
    elevation: elevation,
    leading: enableLeading
        ? IconButton(
            icon: Icon(leadingIcon, size: 28, color: contentColor, textDirection: TextDirection.ltr),
            onPressed: leadingOnPressed,
          )
        : null,
    actions: [
      IconButton(
        icon: Icon(Icons.arrow_back, size: 22, color: contentColor, textDirection: TextDirection.ltr),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

// --------------------------------------------------------------------------------------------------------------------
