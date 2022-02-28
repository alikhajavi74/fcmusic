import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// Hex color class:

class MHexColor extends Color {
  MHexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

// --------------------------------------------------------------------------------------------------------------------

// My colors:

class MColors {
  // Red:
  static const Color red50 = Color(0xffffebee);
  static const Color red100 = Color(0xffffcdd2);
  static const Color red200 = Color(0xffef9a9a);
  static const Color red300 = Color(0xffe57373);
  static const Color red400 = Color(0xffef5350);
  static const Color red500 = Color(0xfff44336);
  static const Color red600 = Color(0xffe53935);
  static const Color red700 = Color(0xffd32f2f);
  static const Color red800 = Color(0xffc62828);
  static const Color red900 = Color(0xffb71c1c);

  // Pink:
  static const Color pink50 = Color(0xfffce4ec);
  static const Color pink100 = Color(0xfff8bbd0);
  static const Color pink200 = Color(0xfff48fb1);
  static const Color pink300 = Color(0xfff06292);
  static const Color pink400 = Color(0xffec407a);
  static const Color pink500 = Color(0xffe91e63);
  static const Color pink600 = Color(0xffd81b60);
  static const Color pink700 = Color(0xffc2185b);
  static const Color pink800 = Color(0xffad1457);
  static const Color pink900 = Color(0xff880e4f);

  // Purple:
  static const Color purple50 = Color(0xfff3e5f5);
  static const Color purple100 = Color(0xffe1bee7);
  static const Color purple200 = Color(0xffce93d8);
  static const Color purple300 = Color(0xffba68c8);
  static const Color purple400 = Color(0xffab47bc);
  static const Color purple500 = Color(0xff9c27b0);
  static const Color purple600 = Color(0xff8e24aa);
  static const Color purple700 = Color(0xff7b1fa2);
  static const Color purple800 = Color(0xff6a1b9a);
  static const Color purple900 = Color(0xff4a148c);

  // DeepPurple:
  static const Color deepPurple50 = Color(0xffede7f6);
  static const Color deepPurple100 = Color(0xffd1c4e9);
  static const Color deepPurple200 = Color(0xffb39ddb);
  static const Color deepPurple300 = Color(0xff9575cd);
  static const Color deepPurple400 = Color(0xff7e57c2);
  static const Color deepPurple500 = Color(0xff673ab7);
  static const Color deepPurple600 = Color(0xff5e35b1);
  static const Color deepPurple700 = Color(0xff512da8);
  static const Color deepPurple800 = Color(0xff4527a0);
  static const Color deepPurple900 = Color(0xff311b92);

  // Indigo:
  static const Color indigo50 = Color(0xffe8eaf6);
  static const Color indigo100 = Color(0xffc5cae9);
  static const Color indigo200 = Color(0xff9fa8da);
  static const Color indigo300 = Color(0xff7986cb);
  static const Color indigo400 = Color(0xff5c6bc0);
  static const Color indigo500 = Color(0xff3f51b5);
  static const Color indigo600 = Color(0xff3949ab);
  static const Color indigo700 = Color(0xff303f9f);
  static const Color indigo800 = Color(0xff283593);
  static const Color indigo900 = Color(0xff1a237e);

  // Blue:
  static const Color blue50 = Color(0xffe3f2fd);
  static const Color blue70 = Color(0xffdaeefe);
  static const Color blue100 = Color(0xffbbdefb);
  static const Color blue200 = Color(0xff90caf9);
  static const Color blue300 = Color(0xff64b5f6);
  static const Color blue400 = Color(0xff42a5f5);
  static const Color blue500 = Color(0xff2196f3);
  static const Color blue600 = Color(0xff1e88e5);
  static const Color blue700 = Color(0xff1976d2);
  static const Color blue800 = Color(0xff1565c0);
  static const Color blue900 = Color(0xff0d47a1);

  // LightBlue:
  static const Color lightBlue50 = Color(0xffe1f5fe);
  static const Color lightBlue100 = Color(0xffb3e5fc);
  static const Color lightBlue200 = Color(0xff81d4fa);
  static const Color lightBlue300 = Color(0xff4fc3f7);
  static const Color lightBlue400 = Color(0xff29b6f6);
  static const Color lightBlue500 = Color(0xff03a9f4);
  static const Color lightBlue600 = Color(0xff039be5);
  static const Color lightBlue700 = Color(0xff0288d1);
  static const Color lightBlue800 = Color(0xff0277bd);
  static const Color lightBlue900 = Color(0xff01579b);

  // Cyan:
  static const Color cyan50 = Color(0xffe0f7fa);
  static const Color cyan100 = Color(0xffb2ebf2);
  static const Color cyan200 = Color(0xff80deea);
  static const Color cyan300 = Color(0xff4dd0e1);
  static const Color cyan400 = Color(0xff26c6da);
  static const Color cyan500 = Color(0xff00bcd4);
  static const Color cyan600 = Color(0xff00acc1);
  static const Color cyan700 = Color(0xff0097a7);
  static const Color cyan800 = Color(0xff00838f);
  static const Color cyan900 = Color(0xff006064);

  // Teal:
  static const Color teal50 = Color(0xffe0f2f1);
  static const Color teal100 = Color(0xffb2dfdb);
  static const Color teal200 = Color(0xff80cbc4);
  static const Color teal300 = Color(0xff4db6ac);
  static const Color teal400 = Color(0xff26a69a);
  static const Color teal500 = Color(0xff009688);
  static const Color teal600 = Color(0xff00897b);
  static const Color teal700 = Color(0xff00796b);
  static const Color teal800 = Color(0xff00695c);
  static const Color teal900 = Color(0xff004d40);

  // Green:
  static const Color green50 = Color(0xffe8f5e9);
  static const Color green100 = Color(0xffc8e6c9);
  static const Color green200 = Color(0xffa5d6a7);
  static const Color green300 = Color(0xff81c784);
  static const Color green400 = Color(0xff66bb6a);
  static const Color green500 = Color(0xff4caf50);
  static const Color green600 = Color(0xff43a047);
  static const Color green700 = Color(0xff388e3c);
  static const Color green800 = Color(0xff2e7d32);
  static const Color green900 = Color(0xff1b5e20);

  // LightGreen:
  static const Color lightGreen50 = Color(0xfff1f8e9);
  static const Color lightGreen100 = Color(0xffdcedc8);
  static const Color lightGreen200 = Color(0xffc5e1a5);
  static const Color lightGreen300 = Color(0xffaed581);
  static const Color lightGreen400 = Color(0xff9ccc65);
  static const Color lightGreen500 = Color(0xff8bc34a);
  static const Color lightGreen600 = Color(0xff7cb342);
  static const Color lightGreen700 = Color(0xff689f38);
  static const Color lightGreen800 = Color(0xff558b2f);
  static const Color lightGreen900 = Color(0xff33691e);

  // Lime:
  static const Color lime50 = Color(0xfff9fbe7);
  static const Color lime100 = Color(0xfff0f4c3);
  static const Color lime200 = Color(0xffe6ee9c);
  static const Color lime300 = Color(0xffdce775);
  static const Color lime400 = Color(0xffd4e157);
  static const Color lime500 = Color(0xffcddc39);
  static const Color lime600 = Color(0xffc0ca33);
  static const Color lime700 = Color(0xffafb42b);
  static const Color lime800 = Color(0xff9e9d24);
  static const Color lime900 = Color(0xff827717);

  // Yellow:
  static const Color yellow50 = Color(0xfffffde7);
  static const Color yellow100 = Color(0xfffff9c4);
  static const Color yellow200 = Color(0xfffff59d);
  static const Color yellow300 = Color(0xfffff176);
  static const Color yellow400 = Color(0xffffee58);
  static const Color yellow500 = Color(0xffffeb3b);
  static const Color yellow600 = Color(0xfffdd835);
  static const Color yellow700 = Color(0xfffbc02d);
  static const Color yellow800 = Color(0xfff9a825);
  static const Color yellow900 = Color(0xfff57f17);

  // Amber:
  static const Color amber50 = Color(0xfffff8e1);
  static const Color amber100 = Color(0xffffecb3);
  static const Color amber200 = Color(0xffffe082);
  static const Color amber300 = Color(0xffffd54f);
  static const Color amber400 = Color(0xffffca28);
  static const Color amber500 = Color(0xffffc107);
  static const Color amber600 = Color(0xffffb300);
  static const Color amber700 = Color(0xffffa000);
  static const Color amber800 = Color(0xffff8f00);
  static const Color amber900 = Color(0xffff6f00);

  // Orange:
  static const Color orange50 = Color(0xfffff3e0);
  static const Color orange100 = Color(0xffffe0b2);
  static const Color orange200 = Color(0xffffcc80);
  static const Color orange300 = Color(0xffffb74d);
  static const Color orange400 = Color(0xffffa726);
  static const Color orange500 = Color(0xffff9800);
  static const Color orange600 = Color(0xfffb8c00);
  static const Color orange700 = Color(0xfff57c00);
  static const Color orange800 = Color(0xffef6c00);
  static const Color orange900 = Color(0xffe65100);

  // DeepOrange:
  static const Color deepOrange50 = Color(0xfffbe9e7);
  static const Color deepOrange100 = Color(0xffffccbc);
  static const Color deepOrange200 = Color(0xffffab91);
  static const Color deepOrange300 = Color(0xffff8a65);
  static const Color deepOrange400 = Color(0xffff7043);
  static const Color deepOrange500 = Color(0xffff5722);
  static const Color deepOrange600 = Color(0xfff4511e);
  static const Color deepOrange700 = Color(0xffe64a19);
  static const Color deepOrange800 = Color(0xffd84315);
  static const Color deepOrange900 = Color(0xffbf360c);

  // Brown:
  static const Color brown50 = Color(0xffefebe9);
  static const Color brown100 = Color(0xffd7ccc8);
  static const Color brown200 = Color(0xffbcaaa4);
  static const Color brown300 = Color(0xffa1887f);
  static const Color brown400 = Color(0xff8d6e63);
  static const Color brown500 = Color(0xff795548);
  static const Color brown600 = Color(0xff6d4c41);
  static const Color brown700 = Color(0xff5d4037);
  static const Color brown800 = Color(0xff4e342e);
  static const Color brown900 = Color(0xff3e2723);

  // Grey:
  static const Color grey50 = Color(0xfffafafa);
  static const Color grey100 = Color(0xfff5f5f5);
  static const Color grey200 = Color(0xffeeeeee);
  static const Color grey300 = Color(0xffe0e0e0);
  static const Color grey400 = Color(0xffbdbdbd);
  static const Color grey500 = Color(0xff9e9e9e);
  static const Color grey600 = Color(0xff757575);
  static const Color grey700 = Color(0xff616161);
  static const Color grey800 = Color(0xff424242);
  static const Color grey900 = Color(0xff212121);

  // BlueGrey:
  static const Color blueGrey50 = Color(0xffeceff1);
  static const Color blueGrey100 = Color(0xffcfd8dc);
  static const Color blueGrey200 = Color(0xffb0bec5);
  static const Color blueGrey300 = Color(0xff90a4ae);
  static const Color blueGrey400 = Color(0xff78909c);
  static const Color blueGrey500 = Color(0xff607d8b);
  static const Color blueGrey600 = Color(0xff546e7a);
  static const Color blueGrey700 = Color(0xff455a64);
  static const Color blueGrey800 = Color(0xff37474f);
  static const Color blueGrey900 = Color(0xff263238);

  // DarkGrey (Black):
  static const Color darkGrey50 = Color(0xffc7c7c7);
  static const Color darkGrey100 = Color(0xffc2c2c2);
  static const Color darkGrey200 = Color(0xffbcbcbc);
  static const Color darkGrey300 = Color(0xffaeaeae);
  static const Color darkGrey400 = Color(0xff8d8d8d);
  static const Color darkGrey500 = Color(0xff707070);
  static const Color darkGrey600 = Color(0xff494949);
  static const Color darkGrey700 = Color(0xff373737);
  static const Color darkGrey800 = Color(0xff1b1b1b);
  static const Color darkGrey900 = Color(0xff000000);

  // DarkBlueGrey:
  static const Color darkBlueGrey50 = Color(0xffbabdbe);
  static const Color darkBlueGrey100 = Color(0xff9ea7aa);
  static const Color darkBlueGrey200 = Color(0xff808e95);
  static const Color darkBlueGrey300 = Color(0xff62757f);
  static const Color darkBlueGrey400 = Color(0xff4b636e);
  static const Color darkBlueGrey500 = Color(0xff34515e);
  static const Color darkBlueGrey600 = Color(0xff29434e);
  static const Color darkBlueGrey700 = Color(0xff1c313a);
  static const Color darkBlueGrey800 = Color(0xff102027);
  static const Color darkBlueGrey900 = Color(0xff000a12);
}

// --------------------------------------------------------------------------------------------------------------------

// My special gradients:

class MGradientColors {
  // gradient with two colors:
  static List<Color> sexylBlueTwoColors = [const Color(0xff2193b0), const Color(0xff6dd5ed)];
  static List<Color> oceenBlueTwoColors = [const Color(0xff2e3192), const Color(0xff1BFFFF)];
  static List<Color> socialiveTwoColors = [const Color(0xff06beb6), const Color(0xff48b1bf)];
  static List<Color> greenBeachTwoColors = [const Color(0xff02aab0), const Color(0xff00cdac)];
  static List<Color> bloodyMaryTwoColors = [const Color(0xffff512f), const Color(0xffdd2476)];
  static List<Color> canYouFeelTheLoveTonightTwoColors = [const Color(0xff4568dc), const Color(0xffb06ab3)];
  static List<Color> scooterTwoColors = [const Color(0xff36d1dc), const Color(0xff5b86e5)];
  static List<Color> quepalTwoColors = [const Color(0xff11998e), const Color(0xff38ef7d)];

  // gradient with three colors:
  static List<Color> coolBlueThreeColors = const [Colors.lightBlueAccent, Colors.blue, Colors.blueAccent];
  static List<Color> wonderThreeColors = [const Color(0xffd2589d), const Color(0xff5f8fe9), const Color(0xff26c3fc)];
  static List<Color> wonderLightThreeColors = [const Color(0xffd16ba5), const Color(0xff86a8e7), const Color(0xff5ffbf1)];
}

// --------------------------------------------------------------------------------------------------------------------
