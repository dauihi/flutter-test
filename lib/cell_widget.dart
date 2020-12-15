import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_flutter/cell_inner_widget.dart';
import 'cell_inner_widget.dart';
import 'util.dart';

enum DataType { section, text, btn, switchBtn, image, number, choose }

class CellData {
  DataType dataType;
  String text;
  String imageName;
  Color color;
  TheThemeType theThemeType;
  bool curShowImage;
  final void Function(TheThemeType, bool) onButtonPressed;

  CellData(
      {this.dataType,
      this.text,
      this.imageName,
      this.color,
      this.onButtonPressed,
      this.theThemeType,
      this.curShowImage});

  void setColor(Color color) {
    this.color = color;
  }
}

class CellWidget extends StatefulWidget {
  final CellData cellData;

  const CellWidget({Key key, this.cellData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CellWidgetState();
  }
}

class CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (this.widget.cellData.dataType) {
      case DataType.text:
        {
          return new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 30),
                        CellImageWidget(
                          imageName: this.widget.cellData.imageName,
                          width: 20,
                          height: 20,
                          rightPad: 5,
                        ),
                        CellTextWidget(
                          text: this.widget.cellData.text,
                          leftPad: 0,
                          color: this.widget.cellData.color,
                        ),
                        // SizedBox(width: 80),
                      ],
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CellTextWidget(
                        text: "子" + this.widget.cellData.text,
                        color: this.widget.cellData.color,
                      ),
                      CellImageWidget(
                        imageName: "tableview_arrow_8x13.png",
                        width: 8,
                        height: 8,
                        rightPad: 20,
                      )
                    ],
                  )
                ],
              ),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
        break;
      case DataType.choose:
        {
          return new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: CellTextWidget(
                      text: this.widget.cellData.text,
                      color: this.widget.cellData.color,
                    ),
                  ),
                  CellButtonWidget(
                    onButtonPressed: (theThemeType, showImage) {
                      this
                          .widget
                          .cellData
                          .onButtonPressed(theThemeType, showImage);
                    },
                    theThemeType: this.widget.cellData.theThemeType,
                    curShowImage: this.widget.cellData.curShowImage,
                  )
                ],
              ),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
        break;
      case DataType.section:
        {
          if (this.widget.cellData.text == "") {
            return new Column(
              children: [
                new SizedBox(
                  height: 5,
                ),
                new Container(
                  height: 0.5,
                  color: this.widget.cellData.color,
                )
              ],
            );
          } else {
            return new Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                          ),
                          Text(this.widget.cellData.text),
                        ],
                      )
                    ]),
                new Container(
                  height: 0.5,
                  color: this.widget.cellData.color,
                )
              ],
            );
          }
        }
        break;
      case DataType.number:
        {
          return new Column(
            children: [
              new Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: new Center(
                    child: Text(
                      this.widget.cellData.text,
                      style: TextStyle(color: this.widget.cellData.color),
                    ),
                  )),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
        break;
      case DataType.image:
        {
          double width = 60;
          if (this.widget.cellData.text == "7") {
            width = 30;
          }

          return new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 35),
                        CellTextWidget(
                          text: this.widget.cellData.text,
                          leftPad: 0,
                          color: this.widget.cellData.color,
                        ),
                        // SizedBox(width: 80),
                      ],
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CellImageWidget(
                        imageName: this.widget.cellData.imageName,
                        width: width,
                        height: width,
                        rightPad: 0,
                      ),
                      CellImageWidget(
                        imageName: "tableview_arrow_8x13.png",
                        width: 8,
                        height: 8,
                        rightPad: 20,
                      )
                    ],
                  )
                ],
              ),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
        break;
      case DataType.switchBtn:
        {
          bool isTrue = true;
          if (this.widget.cellData.text == "6") {
            isTrue = false;
          }
          return new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 35),
                        CellTextWidget(
                          text: this.widget.cellData.text,
                          leftPad: 0,
                          color: this.widget.cellData.color,
                        ),
                        // SizedBox(width: 80),
                      ],
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoSwitch(
                        value: isTrue,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        trackColor: Colors.blueAccent,
                      )
                    ],
                  )
                ],
              ),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
        break;
      case DataType.btn:
        {
          return new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 35),
                        CellTextWidget(
                          text: this.widget.cellData.text,
                          leftPad: 0,
                          color: this.widget.cellData.color,
                        ),
                        // SizedBox(width: 80),
                      ],
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        child: Text("随便吧"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      CellImageWidget(
                        imageName: "tableview_arrow_8x13.png",
                        width: 8,
                        height: 8,
                        rightPad: 20,
                      )
                    ],
                  )
                ],
              ),
              new Container(
                height: 0.5,
                color: this.widget.cellData.color,
              )
            ],
          );
        }
    }
  }
}
