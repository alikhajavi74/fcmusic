// PubDev main package: https://pub.dev/packages/ansicolor

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

// --------------------------------------------------------------------------------------------------------------------

// My printers:

void mPrint(Object object) {
  if (kDebugMode) {
    ansiColorDisabled = false;
    AnsiPen pen = AnsiPen()..yellow(bold: true);
    print(pen(object));
  }
}

void mPrintGreen(Object object) {
  if (kDebugMode) {
    ansiColorDisabled = false;
    AnsiPen pen = AnsiPen()..green(bold: true);
    print(pen(object));
  }
}

void mPrintRed(Object object) {
  if (kDebugMode) {
    ansiColorDisabled = false;
    AnsiPen pen = AnsiPen()..red(bold: true);
    print(pen(object));
  }
}

void mPrintLBlue(Object object) {
  if (kDebugMode) {
    ansiColorDisabled = false;
    AnsiPen pen = AnsiPen()
      ..white()
      ..rgb(r: 0, g: 255, b: 255);
    print(pen(object));
  }
}

void mPrintPink(Object object) {
  if (kDebugMode) {
    ansiColorDisabled = false;
    AnsiPen pen = AnsiPen()
      ..white()
      ..rgb(r: 255, g: 0, b: 255);
    print(pen(object));
  }
}

// --------------------------------------------------------------------------------------------------------------------
