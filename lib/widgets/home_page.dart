import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'cell_widget.dart';
import 'theme_type_notifier.dart';
import '../model/ori_cell_data.dart';
import '../model/theme_data.dart';
import 'cell_widget.dart';
import 'choose_theme_page.dart';
import '../model/theme_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TheThemeType curThemeType = TheThemeType.white;

  var _data = [];

  @override
  void initState() {
    super.initState();

    reloadData();
  }

  reloadData() async {
    List<OriCellData> oriList = await getOriCellDatas();
    List<CellData> cellDataList = getCellDataList(oriList);
    setState(() {
      _data = cellDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theThemeType = Provider.of<ThemeTypeNotifier>(context).theThemeType;
    curThemeType = theThemeType;
    TheThemeData _curThemeData = getThemeData(curThemeType);
    // TODO: implement build
    return Scaffold(
        backgroundColor: _curThemeData.backgroundColor,
        appBar: new AppBar(
          title: Text('切换主题Demo'),
          centerTitle: true,
          backgroundColor: _curThemeData.backgroundColor,
          textTheme: TextTheme(
            title: TextStyle(
                color: _curThemeData.barTextColor,
                fontSize: _curThemeData.barTextFontSize),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: _curThemeData.buttonBackgroundColor,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new ChooseThemePage(
                    curThemeType: this.curThemeType,
                  );
                })).then((value) {
                  // this.curThemeType = value;

                  // setState(() {});
                });
              },
            )
          ],
        ),
        body: new ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            CellData curData = _data[index];
            curData.setTheme(_curThemeData);
            return CellWidget(cellData: curData);
          },
        ));
  }
}
