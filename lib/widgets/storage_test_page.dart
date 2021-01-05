import 'package:flutter/material.dart';
import '../storage/storage.dart';

class StorageTestWidget extends StatefulWidget {
  StorageTestWidget({Key key}) : super(key: key);

  @override
  _StorageTestWidgetState createState() => _StorageTestWidgetState();
}

class _StorageTestWidgetState extends State<StorageTestWidget> {
  final String userNameKey = 'testUserName';
  final _userNameContrller = new TextEditingController();
  final SaveType saveType = SaveType.pre;

  @override
  Widget build(BuildContext context) {
    return new Builder(builder: (BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("SharePreferences"),
        ),
        body: Center(
          child: new Builder(
            builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  TextField(
                    controller: _userNameContrller,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        icon: Icon(Icons.perm_identity),
                        labelText: "用户名",
                        helperText: "用户名"),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Text("存储"),
                    onPressed: () {
                      saveVal(saveType, userNameKey,
                          _userNameContrller.value.text.toString());
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: Text("数据存储成功"),
                      ));
                    },
                  ),
                  RaisedButton(
                    color: Colors.greenAccent,
                    child: Text("获取"),
                    onPressed: () {
                      Future<String> userName = getVal(saveType, userNameKey);
                      userName.then((String userName) => {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("数据获取成功: $userName"),
                            ))
                          });
                    },
                  )
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
