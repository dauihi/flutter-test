import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

getImageTotalName(String name) {
  return 'assets/images/' + name;
}

enum TheThemeType { white, black, red, blue }

class TheThemeData {
  Color color;
  Color otherColor;

  TheThemeData(this.color, this.otherColor);
}

TheThemeData getThemeData(TheThemeType type) {
  switch (type) {
    case TheThemeType.white:
      return TheThemeData(Colors.white, Colors.black);
      break;
    case TheThemeType.black:
      return TheThemeData(Colors.black, Colors.white);
      break;
    case TheThemeType.red:
      return TheThemeData(Colors.red, Colors.white);
      break;
    case TheThemeType.blue:
      return TheThemeData(Colors.blue, Colors.white);
      break;
  }
}
