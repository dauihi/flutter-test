import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TheThemeType { white, black, red, blue }

class TheThemeData {
  Color backgroundColor;
  Color barTextColor;
  Color buttonBackgroundColor;
  Color switchActiveColor;
  Color switchTrackColor;
  Color cellTextColor;
  double barTextFontSize;
  double cellTextFontSize;

  TheThemeData(
      this.backgroundColor,
      this.barTextColor,
      this.buttonBackgroundColor,
      this.switchActiveColor,
      this.switchTrackColor,
      this.cellTextColor,
      this.barTextFontSize,
      this.cellTextFontSize);
}

TheThemeData getThemeData(TheThemeType type) {
  switch (type) {
    case TheThemeType.white:
      return TheThemeData(Colors.white, Colors.black, Colors.orange,
          Colors.green, Colors.white, Colors.black, 18, 12);
      break;
    case TheThemeType.black:
      return TheThemeData(Colors.black, Colors.white, Colors.purple,
          Colors.blue, Colors.yellow, Colors.white, 14, 10);
      break;
    case TheThemeType.red:
      return TheThemeData(Colors.red, Colors.green, Colors.cyan, Colors.black,
          Colors.yellow, Colors.blue, 20, 15);
      ;
      break;
    case TheThemeType.blue:
      return TheThemeData(Colors.blue, Colors.black, Colors.grey, Colors.yellow,
          Colors.green, Colors.red, 4, 10);
      break;
  }
}
