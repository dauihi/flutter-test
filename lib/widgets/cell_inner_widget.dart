import 'dart:ffi';

import 'package:flutter/material.dart';
import '../utils/util.dart';
import 'theme_data.dart';

class CellTextWidget extends StatefulWidget {
  final String text;
  final double leftPad;
  final Color color;

  const CellTextWidget({Key key, this.text, this.leftPad, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CellTextState();
  }
}

class CellTextState extends State<CellTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: this.widget.leftPad),
          Text(
            this.widget.text,
            style: TextStyle(color: this.widget.color),
          )
        ],
      ),
    );
  }
}

class CellImageWidget extends StatefulWidget {
  final String imageName;
  final double width;
  final double height;
  final double rightPad;

  const CellImageWidget(
      {Key key, this.imageName, this.width, this.height, this.rightPad})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CellImageState();
  }
}

class CellImageState extends State<CellImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 30,
      // height: 30,
      padding: EdgeInsets.fromLTRB(0, 0, this.widget.rightPad, 0),
      child: Row(
        children: <Widget>[
          Image.asset(
            getImageTotalName(this.widget.imageName),
            width: this.widget.width,
            height: this.widget.height,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}

class CellButtonWidget extends StatefulWidget {
  final void Function(TheThemeType, bool) onButtonPressed;
  final TheThemeType theThemeType;
  bool curShowImage;

  CellButtonWidget(
      {Key key, this.theThemeType, this.onButtonPressed, this.curShowImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CellButtonState();
  }
}

class CellButtonState extends State<CellButtonWidget> {
  void updateImageState(bool showImage) {
    this.widget.curShowImage = showImage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (this.widget.curShowImage) {
      child = Image.asset(
        getImageTotalName("icon_selected_20x20.png"),
        width: 20,
        height: 20,
        fit: BoxFit.fitWidth,
      );
    } else {
      child = SizedBox(
        height: 30,
      );
    }

    return FlatButton(
      child: child,
      onPressed: () {
        setState(() {
          this.widget.curShowImage = !this.widget.curShowImage;
        });
        this.widget.onButtonPressed(
            this.widget.theThemeType, this.widget.curShowImage);
      },
    );
  }
}
