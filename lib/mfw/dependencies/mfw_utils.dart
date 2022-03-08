import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'mfw_main_typedefs.dart';

// --------------------------------------------------------------------------------------------------------------------

// Half space string:

const String halfspace = "\u200c";

// --------------------------------------------------------------------------------------------------------------------

// Exit from app:

void exitForAndroidAndIOS() {
  if (Platform.isAndroid) {
    exitBetterForAndroid();
  } else if (Platform.isIOS) {
    exitBetterForIOS();
  }
}

void exitBetterForAndroid() => SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // best way for android and always works

void exitBetterForIOS() => exit(0); // Works but Apple may suspend your app so instead this way u can minimize your app

// --------------------------------------------------------------------------------------------------------------------

// Converters:

String thousandSeprator(dynamic number) {
  var formatter = NumberFormat('###,###');
  return formatter.format(number);
}

String tomanFormatter(dynamic number) {
  var formatter = NumberFormat.currency(locale: "fa-IR", symbol: "تومان");
  return formatter.format(number);
}

String convertPersianNumbersToEnglishNumbers(String string) {
  // ۰۱۲۳۴۵۶۷۸۹ to 0123456789
  return string.replaceAll("۰", "0").replaceAll("۱", "1").replaceAll("۲", "2").replaceAll("۳", "3").replaceAll("۴", "4").replaceAll("۵", "5").replaceAll("۶", "6").replaceAll("۷", "7").replaceAll("۸", "8").replaceAll("۹", "9");
}

String convertDurationToMinute1(Duration duration) {
  return "${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
}

String convertDurationToMinute2(Duration duration) {
  return duration.toString().substring(2, 7);
}

// --------------------------------------------------------------------------------------------------------------------

// Widget binding:

void mWidgetBindig(BuildContext context, MVoidCallbackWithContext function) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    function(context);
  });
}

// --------------------------------------------------------------------------------------------------------------------
