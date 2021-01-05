import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:text_flutter/widgets/cell_widget.dart';
import 'package:text_flutter/widgets/theme_type_notifier.dart';
import '../model/ori_cell_data.dart';
import '../model/theme_data.dart';
import 'cell_widget.dart';

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
      backgroundColor: _curThemeData.backgroundColor,
      appBar: new AppBar(
        title: Text("选择主题"),
        textTheme: TextTheme(
          title: TextStyle(color: _curThemeData.barTextColor, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: _curThemeData.backgroundColor,
        leading: FlatButton(
          child: Text(
            "取消",
            style:
                new TextStyle(fontSize: 12, color: _curThemeData.barTextColor),
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
                  Navigator.pop(context);
                  // Navigator.pop(context, this.widget.curThemeType);
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
          CellData cellData = CellData(
              theThemeType: theThemeType,
              dataType: DataType.choose,
              text: curData,
              imageName: "",
              curShowImage: isShowImage,
              backgroundColor: _curThemeData.barTextColor,
              onButtonPressed: (theThemeType, showImage) {
                if (showImage) {
                  this.widget.curThemeType = theThemeType;
                  setState(() {});

                  Provider.of<ThemeTypeNotifier>(context, listen: false)
                      .changeThemeType(theThemeType);
                }
              });
          cellData.setTheme(_curThemeData);

          return CellWidget(
            cellData: cellData,
          );
        },
      ),
    );
  }
}
