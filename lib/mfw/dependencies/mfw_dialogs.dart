import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mfw_colors.dart';
import 'mfw_main_typedefs.dart';

// --------------------------------------------------------------------------------------------------------------------

// Simple dialog:

void mShowSimpleDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, String? title, Icon? icon, required String description, TextAlign descriptionTextAlign = TextAlign.center, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  Widget? initTitleWidget(BuildContext context) {
    if (title != null && icon != null) {
      return Column(
        children: [
          icon,
          const SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.w500)),
        ],
      );
    } else if (title != null && icon == null) {
      return Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.w500));
    } else if (title == null && icon != null) {
      return icon;
    }
    return null;
  }

  showDialog<void>(
    context: mainContext,
    barrierDismissible: cancelable,
    builder: (BuildContext dialogBuilderContext) {
      return WillPopScope(
        onWillPop: () async => cancelable,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          title: initTitleWidget(mainContext),
          content: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(color: Colors.white, child: Text(description, textAlign: descriptionTextAlign, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.w500))),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            positiveButtonFunction != null
                ? TextButton(
                    child: Text(positiveButtonText, style: TextStyle(color: Theme.of(dialogBuilderContext).primaryColor, fontSize: 16.0, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.of(mainContext).pop();
                      positiveButtonFunction(mainContext);
                    },
                  )
                : const SizedBox(),
            TextButton(
              child: Text(negativeButtonText, style: const TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500)),
              onPressed: () async {
                if (negativeButtonFunction != null) {
                  Navigator.of(mainContext).pop();
                  negativeButtonFunction(mainContext);
                } else {
                  Navigator.of(mainContext).pop();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void mShowSimpleDialogWidgetBinding(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, String? title, required String description, TextAlign descriptionTextAlign = TextAlign.center, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    mShowSimpleDialog(mainContext, cancelable: cancelable, radius: radius, title: title, description: description, descriptionTextAlign: descriptionTextAlign, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
  });
}

// Simple ready dialogs:

void mShowSuccessSimpleDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.done, color: Colors.green, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  mShowSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
}

void mShowInfoSimpleDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.info, color: Colors.blue, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  mShowSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
}

void mShowErrorSimpleDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.error, color: Colors.red, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  mShowSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
}

void mShowSuccessSimpleDialogWidgetBinding(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.done, color: Colors.green, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    mShowSuccessSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
  });
}

void mShowInfoSimpleDialogWidgetBinding(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.info, color: Colors.blue, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    mShowInfoSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
  });
}

void mShowErrorSimpleDialogWidgetBinding(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Icon icon = const Icon(Icons.error, color: Colors.red, size: 45), required String description, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    mShowErrorSimpleDialog(mainContext, cancelable: cancelable, radius: radius, icon: icon, description: description, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
  });
}

// --------------------------------------------------------------------------------------------------------------------

// Special dialogs:

void mShowSpecialDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Color color = Colors.blue, List<Color>? gradientColors, required String imageAsset, String? title, required String description, TextAlign descriptionTextAlign = TextAlign.center, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  showDialog<void>(
    context: mainContext,
    barrierDismissible: cancelable,
    builder: (BuildContext dialogBuilderContext) {
      return WillPopScope(
        onWillPop: () async => cancelable,
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          content: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      gradient: gradientColors != null ? LinearGradient(colors: gradientColors, begin: Alignment.bottomRight, end: Alignment.topLeft) : LinearGradient(colors: [color, color]),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radius),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset(imageAsset, fit: BoxFit.fill),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            title != null ? Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)) : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(20.0)),
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(color: MColors.grey700, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            positiveButtonFunction != null
                ? TextButton(
                    child: Text(positiveButtonText, style: TextStyle(color: color, fontSize: 16.0, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.of(mainContext).pop();
                      positiveButtonFunction(mainContext);
                    },
                  )
                : const SizedBox(),
            TextButton(
              child: Text(negativeButtonText, style: const TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500)),
              onPressed: () async {
                if (negativeButtonFunction != null) {
                  Navigator.of(mainContext).pop();
                  negativeButtonFunction(mainContext);
                } else {
                  Navigator.of(mainContext).pop();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void mShowSpecialDialogWidgetBinding(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, Color color = Colors.blue, List<Color>? gradientColors, required String imageAsset, String? title, required String description, TextAlign descriptionTextAlign = TextAlign.center, String positiveButtonText = "تایید", String negativeButtonText = "رد کردن", MDynamicCallbackWithContext? positiveButtonFunction, MDynamicCallbackWithContext? negativeButtonFunction}) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    mShowSpecialDialog(mainContext, cancelable: cancelable, radius: radius, color: color, gradientColors: gradientColors, imageAsset: imageAsset, title: title, description: description, descriptionTextAlign: descriptionTextAlign, positiveButtonText: positiveButtonText, negativeButtonText: negativeButtonText, positiveButtonFunction: positiveButtonFunction, negativeButtonFunction: negativeButtonFunction);
  });
}

// --------------------------------------------------------------------------------------------------------------------

// Edit dialog:

typedef MEditDialogFunction = dynamic Function(BuildContext context, String text);

enum MTextInputType { number, phone, email, text }

void mShowEditDialog(BuildContext mainContext, {bool cancelable = true, double radius = 8.0, String? title, required String currentText, required MTextInputType textInputType, int? maxLength, required MEditDialogFunction editDialogFunction}) {
  TextEditingController textEditingController = TextEditingController(text: currentText);
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatter;

  switch (textInputType) {
    case MTextInputType.number:
      keyboardType = TextInputType.number;
      inputFormatter = mTextInputFormatters(MTextInputType.number);
      break;

    case MTextInputType.phone:
      keyboardType = TextInputType.phone;
      inputFormatter = mTextInputFormatters(MTextInputType.phone);
      break;

    case MTextInputType.email:
      keyboardType = TextInputType.emailAddress;
      inputFormatter = mTextInputFormatters(MTextInputType.email);
      break;

    default:
      keyboardType = TextInputType.text;
      inputFormatter = mTextInputFormatters(MTextInputType.text);
  }

  showDialog<void>(
      context: mainContext,
      barrierDismissible: cancelable,
      builder: (BuildContext dialogBuilderContext) {
        return WillPopScope(
          onWillPop: () async => cancelable,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            title: title != null ? Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(dialogBuilderContext).primaryColor, fontSize: 17.0, fontWeight: FontWeight.w500)) : null,
            content: Container(
              color: Colors.white,
              child: TextField(
                controller: textEditingController,
                keyboardType: keyboardType,
                inputFormatters: inputFormatter,
                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w500),
                maxLength: maxLength,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.edit, size: 18),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                child: Text("ویرایش", style: TextStyle(color: Theme.of(dialogBuilderContext).primaryColor, fontSize: 16.0, fontWeight: FontWeight.w600)),
                onPressed: () async {
                  Navigator.of(mainContext).pop();
                  editDialogFunction(mainContext, textEditingController.text);
                },
              ),
              TextButton(
                child: const Text("رد کردن", style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500)),
                onPressed: () => Navigator.of(mainContext).pop(),
              ),
            ],
          ),
        );
      });
}

List<TextInputFormatter>? mTextInputFormatters(MTextInputType textInputType) {
  final List<TextInputFormatter>? textInputFormatters;
  switch (textInputType) {
    case MTextInputType.number:
      textInputFormatters = [FilteringTextInputFormatter.allow(RegExp(r"^[0-9]*$"))];
      break;

    case MTextInputType.phone:
      textInputFormatters = [FilteringTextInputFormatter.allow(RegExp(r"^[+]*[0-9]*$"))];
      break;

    case MTextInputType.email:
      textInputFormatters = null;
      break;

    default:
      textInputFormatters = null;
      break;
  }
  return textInputFormatters;
}

// --------------------------------------------------------------------------------------------------------------------
