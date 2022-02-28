/*
// PubDev main package: https://pub.dev/packages/persian_datetime_picker/example

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

// --------------------------------------------------------------------------------------------------------------------

// Persian date picker:

Future<Jalali?> mShowPersianDatePicker(BuildContext context) async {
  Jalali? pickedDate = await showPersianDatePicker(
    context: context,
    initialDate: Jalali.now(),
    firstDate: Jalali(1350, 1, 1),
    lastDate: Jalali(1450, 1, 1),
    helpText: "",
    locale: const Locale("fa", "IR"),
  );
  return pickedDate;
}

// --------------------------------------------------------------------------------------------------------------------
*/
