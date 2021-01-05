import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/theme_data.dart';

class ThemeTypeNotifier with ChangeNotifier {
  TheThemeType _theThemeType = TheThemeType.white;

  TheThemeType get theThemeType => _theThemeType;

  changeThemeType(TheThemeType theThemeType) {
    _theThemeType = theThemeType;
    notifyListeners();
  }
}
