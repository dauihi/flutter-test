import 'package:flutter/material.dart';
import 'package:collection/wrappers.dart';

class CardTestStateWidget extends StatefulWidget {
  @override
  _CardTestState createState() => _CardTestState();
}

class _CardTestState extends State<CardTestStateWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20 / 9,
                child: Image.asset('assets/images/basketball_check.png'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: ListTile(
                  title: Text('好的'),
                  subtitle: Text("是否"),
                ),
              )
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20 / 9,
                child: Image.asset('assets/images/football_check.png'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: ListTile(
                  title: Text('你好'),
                  subtitle: Text("他的"),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 3,
                    child: Text("这是"),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("不是"),
                  )
                ],
              )
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Text("好的"),
                    color: Colors.red,
                    width: 100,
                    height: 100,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("你好"),
                    ),
                    color: Colors.green,
                    width: 100,
                    height: 100,
                  ))
            ],
          ),
        )
      ],
    );
  }
}

class WrapWidget extends StatefulWidget {
  @override
  _WrapWidgetState createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        TheButton(
          text: "第一",
        ),
        TheButton(
          text: "第二",
        ),
        TheButton(
          text: "第三",
        ),
        TheButton(
          text: "第四",
        ),
        TheButton(
          text: "第五",
        ),
        TheButton(
          text: "第六",
        ),
        TheButton(
          text: "第七",
        ),
        TheButton(
          text: "第八",
        ),
        TheButton(
          text: "第九",
        ),
        TheButton(
          text: "第十",
        ),
      ],
    );
  }
}

class TheButton extends StatelessWidget {
  String text;
  TheButton({this.text});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.text),
      textColor: Theme.of(context).accentColor,
      onPressed: () {},
    );
  }
}

class DateWidget extends StatefulWidget {
  DateWidget({Key key}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  _showDatePicker() async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2099),
        locale: myLocale);
    setState(() {
      _time = picker.toString();
    });
  }

  var _time;

  _showTimePicker() async {
    var picker =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      _time = picker.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          RaisedButton(
            child: Text(_time == null ? '选择日期' : _time),
            onPressed: () => _showDatePicker(),
          ),
          RaisedButton(
            child: Text(_time == null ? '选择时间' : _time),
            onPressed: () => _showTimePicker(),
          )
        ],
      ),
    );
  }
}
