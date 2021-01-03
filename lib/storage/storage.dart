import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SharedPreferencesTest extends StatelessWidget {
  final String userNameKey = 'testUserName';
  final _userNameContrller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(userNameKey, _userNameContrller.value.text.toString());
    }

    Future<String> get() async {
      var userName;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userName = prefs.getString(userNameKey);
      return userName;
    }

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
                      save();
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: Text("数据存储成功"),
                      ));
                    },
                  ),
                  RaisedButton(
                    color: Colors.greenAccent,
                    child: Text("获取"),
                    onPressed: () {
                      Future<String> userName = get();
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

class FileSaveWidget extends StatelessWidget {
  final _userNameController = new TextEditingController();
  final mFile = null;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/file.txt');
  }

  Future<File> save(String name) async {
    final file = await _localFile;
    return file.writeAsString(name);
  }

  @override
  Widget build(BuildContext context) {
    Future<String> get() async {
      final file = await _localFile;
      return file.readAsString();
    }

    return new Builder(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("FileOperator"),
          ),
          body: new Center(
            child: new Builder(
              builder: (BuildContext context) {
                return new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _userNameController,
                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          icon: new Icon(Icons.perm_identity),
                          labelText: "用户名",
                          helperText: "用户名"),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("存储"),
                      onPressed: () {
                        save(_userNameController.text.toString());
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("数据存储成功"),
                        ));
                      },
                    ),
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Text('获取'),
                      onPressed: () {
                        Future<String> userName = get();
                        userName.then((String userName) => {
                              Scaffold.of(context).showSnackBar(new SnackBar(
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
      },
    );
  }
}

class SqliteTestWidget extends StatelessWidget {
  final _userNameController = new TextEditingController();

  Future<String> get _dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + 'name.db';
    return path;
  }

  Future<Database> get _localFile async {
    final path = await _dbPath;

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT)");
    });
    return database;
  }

  Future<int> save(String name) async {
    final db = await _localFile;
    return db.transaction((txn) {
      txn.rawInsert('INSERT INTO user(name) VALUES("$name")');
    });
  }

  Future<List<Map>> get() async {
    final db = await _localFile;
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("SqliteOperator"),
          ),
          body: new Center(
            child: new Builder(
              builder: (BuildContext context) {
                return new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _userNameController,
                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          icon: new Icon(Icons.perm_identity),
                          labelText: "用户名",
                          helperText: "用户名"),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("存储"),
                      onPressed: () {
                        save(_userNameController.text.toString());
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("数据存储成功"),
                        ));
                      },
                    ),
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Text('获取'),
                      onPressed: () {
                        Future<List<Map>> userName = get();
                        userName.then((List<Map> userNames) {
                          String curName = userNames[0]["name"];
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: Text("数据获取成功: $curName)"),
                          ));
                        });
                      },
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
