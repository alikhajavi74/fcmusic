import 'package:flutter/gestures.dart';

TapGestureRecognizer mTapGestureRecognizer(GestureTapCallback? callBack) {
  return TapGestureRecognizer()..onTap = callBack;
}
