import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_flutter/theme_type_notifier.dart';
import 'home_page.dart';

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
      home: HomePage(),
    );
  }
}
