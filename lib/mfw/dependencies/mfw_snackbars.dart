import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// Base snackbar:

ScaffoldFeatureController mShowBaseSnackBar(
  BuildContext context,
  String message, {
  Color backGroundColor = Colors.black,
  Color contentColor = Colors.white,
  bool clearAllCurrentSnackBars = false,
  bool removeCurrentSnackBar = false,
  int durationSeconds = 4,
  double elevation = 8.0,
  double borderRadius = 10.0,
  double margin = 20.0,
  double? padding,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  bool showLeadingIcon = false,
  IconData leadingIcon = Icons.info,
  bool showAction = false,
  String actionTitle = "رد کردن",
  VoidCallback? actionOnPressed,
}) {
  if (clearAllCurrentSnackBars) {
    mClearAllCurrentSnackBars(context);
  } else if (removeCurrentSnackBar) {
    mRemoveCurrentSnackBar(context);
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backGroundColor,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          showLeadingIcon
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(leadingIcon, color: contentColor), const SizedBox(width: 10.0)],
                )
              : const SizedBox(),
          Expanded(child: Text(message, style: TextStyle(color: contentColor, fontFamily: "iransans", fontSize: 15, fontWeight: FontWeight.w400))),
        ],
      ),
      duration: Duration(seconds: durationSeconds),
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      behavior: SnackBarBehavior.floating,
      margin: behavior == SnackBarBehavior.floating ? EdgeInsets.all(margin) : null,
      padding: padding != null ? EdgeInsets.all(padding) : null,
      action: showAction
          ? SnackBarAction(
              label: actionTitle,
              textColor: contentColor,
              onPressed: actionOnPressed ?? () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
            )
          : null,
    ),
  );
}

void mClearAllCurrentSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}

void mRemoveCurrentSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
}

// --------------------------------------------------------------------------------------------------------------------

// Ready snackbars:

ScaffoldFeatureController mShowSuccessSnackBar(BuildContext context, String message, {bool clearAllCurrentSnackBars = false, bool removeCurrentSnackBar = false, int durationSeconds = 4}) {
  return mShowBaseSnackBar(
    context,
    message,
    backGroundColor: Colors.green,
    showLeadingIcon: true,
    leadingIcon: Icons.done,
    clearAllCurrentSnackBars: clearAllCurrentSnackBars,
    removeCurrentSnackBar: removeCurrentSnackBar,
    durationSeconds: durationSeconds,
  );
}

ScaffoldFeatureController mShowInfoSnackBar(BuildContext context, String message, {bool clearAllCurrentSnackBars = false, bool removeCurrentSnackBar = false, int durationSeconds = 4}) {
  return mShowBaseSnackBar(
    context,
    message,
    backGroundColor: Colors.blue,
    showLeadingIcon: true,
    leadingIcon: Icons.info,
    clearAllCurrentSnackBars: clearAllCurrentSnackBars,
    removeCurrentSnackBar: removeCurrentSnackBar,
    durationSeconds: durationSeconds,
  );
}

ScaffoldFeatureController mShowWarningSnackBar(BuildContext context, String message, {bool clearAllCurrentSnackBars = false, bool removeCurrentSnackBar = false, int durationSeconds = 4}) {
  return mShowBaseSnackBar(
    context,
    message,
    backGroundColor: Colors.orange,
    showLeadingIcon: true,
    leadingIcon: Icons.error,
    clearAllCurrentSnackBars: clearAllCurrentSnackBars,
    removeCurrentSnackBar: removeCurrentSnackBar,
    durationSeconds: durationSeconds,
  );
}

ScaffoldFeatureController mShowErrorSnackBar(BuildContext context, String message, {bool clearAllCurrentSnackBars = false, bool removeCurrentSnackBar = false, int durationSeconds = 4}) {
  return mShowBaseSnackBar(
    context,
    message,
    backGroundColor: Colors.red,
    showLeadingIcon: true,
    leadingIcon: Icons.error,
    clearAllCurrentSnackBars: clearAllCurrentSnackBars,
    removeCurrentSnackBar: removeCurrentSnackBar,
    durationSeconds: durationSeconds,
  );
}

// --------------------------------------------------------------------------------------------------------------------

// Loading Snackbar:

ScaffoldFeatureController mShowLoadingSnackBar(
  BuildContext context, {
  String text = "در انجام عملیات ...",
  Color backGroundColor = Colors.black,
  Color contentColor = Colors.white,
  int durationSeconds = 120,
  double elevation = 8.0,
  double borderRadius = 10.0,
  double margin = 20.0,
  double? padding,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  IconData leadingIcon = Icons.info,
}) {
  mClearAllCurrentSnackBars(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backGroundColor,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 15.0,
                height: 15.0,
                child: CircularProgressIndicator(color: contentColor, strokeWidth: 1),
              ),
              const SizedBox(width: 15.0)
            ],
          ),
          Expanded(child: Text(text, style: TextStyle(color: contentColor, fontFamily: "iransans", fontSize: 15, fontWeight: FontWeight.w400))),
        ],
      ),
      duration: Duration(seconds: durationSeconds),
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      behavior: SnackBarBehavior.floating,
      margin: behavior == SnackBarBehavior.floating ? EdgeInsets.all(margin) : null,
      padding: padding != null ? EdgeInsets.all(padding) : null,
    ),
  );
}

// --------------------------------------------------------------------------------------------------------------------
