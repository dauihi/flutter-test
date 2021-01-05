import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_flutter/widgets/theme_type_notifier.dart';
import 'dart:math';
import 'widgets/home_page.dart';
import 'animation/animation_page.dart';
import 'widgets/hero_animation_page.dart';
import 'widgets/gesture_page.dart';
import 'widgets/card_page.dart';
import 'storage/storage.dart';
import 'widgets/form_page.dart';
import 'widgets/network_test_page.dart';

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
      home: NetworkTestWidget(),
    );
  }
}
