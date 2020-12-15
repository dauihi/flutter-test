import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:text_flutter/cell_widget.dart';
import 'package:text_flutter/main.dart';
import 'util.dart';

void main() {
  runApp(MyApp());
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TheThemeType curThemeType = TheThemeType.black;
  var _data = [
    CellData(
      dataType: DataType.text,
      text: "0",
      imageName: "football_check.png",
    ),
    CellData(dataType: DataType.text, text: "1", imageName: "check_open.png"),
    CellData(
        dataType: DataType.text, text: "0", imageName: "basketball_check.png"),
    CellData(dataType: DataType.section, text: "", imageName: ""),
    CellData(dataType: DataType.btn, text: "11", imageName: ""),
    CellData(dataType: DataType.section, text: "", imageName: ""),
    CellData(dataType: DataType.switchBtn, text: "5", imageName: ""),
    CellData(dataType: DataType.switchBtn, text: "6", imageName: ""),
    CellData(
        dataType: DataType.section, text: "section2 footer", imageName: ""),
    CellData(
        dataType: DataType.image,
        text: "7",
        imageName: "About_WeChat_AppIcon_64x64.png"),
    CellData(
        dataType: DataType.image, text: "8", imageName: "default_100x100.png"),
    CellData(dataType: DataType.section, text: "", imageName: ""),
    CellData(
        dataType: DataType.choose,
        text: "9",
        imageName: "",
        onButtonPressed: (theThemeType, showImage) {},
        curShowImage: false),
    CellData(
        dataType: DataType.choose,
        text: "10",
        imageName: "",
        onButtonPressed: (theThemeType, showImage) {},
        curShowImage: false),
    CellData(dataType: DataType.section, text: "", imageName: ""),
    CellData(dataType: DataType.number, text: "3", imageName: ""),
    CellData(dataType: DataType.number, text: "4", imageName: ""),
  ];

  @override
  Widget build(BuildContext context) {
    TheThemeData _curThemeData = getThemeData(curThemeType);
    // TODO: implement build
    return Scaffold(
        backgroundColor: _curThemeData.color,
        appBar: new AppBar(
          title: Text('切换主题Demo'),
          centerTitle: true,
          backgroundColor: _curThemeData.color,
          textTheme: TextTheme(
            title: TextStyle(color: _curThemeData.otherColor, fontSize: 18),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: _curThemeData.otherColor,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new ChooseThemePage(
                    curThemeType: this.curThemeType,
                  );
                })).then((value) {
                  this.curThemeType = value;

                  setState(() {});
                });
              },
            )
          ],
        ),
        body: new ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            CellData curData = _data[index];
            curData.setColor(_curThemeData.otherColor);
            return CellWidget(cellData: curData);
          },
        ));
  }
}

class ChooseThemePage extends StatefulWidget {
  TheThemeType curThemeType;
  ChooseThemePage({Key key, this.curThemeType}) : super(key: key);

  @override
  _ChooseThemePageState createState() => _ChooseThemePageState();
}

class _ChooseThemePageState extends State<ChooseThemePage> {
  var _data = ["white", "black", "blue", "red"];
  TheThemeData _curThemeData;
  @override
  Widget build(BuildContext context) {
    _curThemeData = getThemeData(this.widget.curThemeType);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _curThemeData.color,
      appBar: new AppBar(
        title: Text("选择主题"),
        textTheme: TextTheme(
          title: TextStyle(color: _curThemeData.otherColor, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: _curThemeData.color,
        leading: FlatButton(
          child: Text(
            "取消",
            style: new TextStyle(fontSize: 12, color: _curThemeData.otherColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: SizedBox(
              width: 60,
              child: new FlatButton(
                color: Colors.green,
                child: Text(
                  "完成",
                  style: new TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  Navigator.pop(context, this.widget.curThemeType);
                },
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          var curData = _data[index];
          TheThemeType theThemeType = [
            TheThemeType.white,
            TheThemeType.black,
            TheThemeType.blue,
            TheThemeType.red
          ][index];
          bool isShowImage = false;
          if (theThemeType == this.widget.curThemeType) {
            isShowImage = true;
          }
          return CellWidget(
            cellData: CellData(
                theThemeType: theThemeType,
                dataType: DataType.choose,
                text: curData,
                imageName: "",
                curShowImage: isShowImage,
                color: _curThemeData.otherColor,
                onButtonPressed: (theThemeType, showImage) {
                  if (showImage) {
                    this.widget.curThemeType = theThemeType;
                    setState(() {});
                  }
                }),
          );
        },
      ),
    );
  }
}
