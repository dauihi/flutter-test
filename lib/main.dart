import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_flutter/theme_type_notifier.dart';
import 'dart:math';
import 'home_page.dart';
import 'animation_page.dart';
import 'hero_animation_page.dart';
import 'gesture_page.dart';
import 'new_page.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeTypeNotifier>.value(
    value: ThemeTypeNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DateWidget(),
    );
  }
}
