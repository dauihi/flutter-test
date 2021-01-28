library storage_plugin;

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

enum SaveType { pre, file, db }

void saveVal(SaveType type, String key, String value) async {
  switch (type) {
    case SaveType.pre:
      {
        await _saveToPre(key, value);
      }
      break;
    case SaveType.file:
      {
        await _saveToLocalFile(value);
      }
      break;
    case SaveType.db:
      {
        await _saveToDb(value);
      }
      break;
  }
}

Future<String> getVal(SaveType type, String key) async {
  var val;
  switch (type) {
    case SaveType.pre:
      {
        val = await _getFromPre(key);
      }
      break;
    case SaveType.file:
      {
        val = await _getFromLocalFile();
      }
      break;
    case SaveType.db:
      {
        List<Map> list = await _getFromDb();
        if (list.length > 0) {
          val = list[0]["name"];
        }
      }
      break;
  }
  return val;
}

Future<bool> _saveToPre(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, value);
}

Future<String> _getFromPre(String key) async {
  var userName;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userName = prefs.getString(key);
  return userName;
}

Future<String> _getLocalDirPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _getLocalFile() async {
  final path = await _getLocalDirPath();
  return new File('$path/file.txt');
}

Future<File> _saveToLocalFile(String name) async {
  final file = await _getLocalFile();
  return file.writeAsString(name);
}

Future<String> _getFromLocalFile() async {
  final file = await _getLocalFile();
  return file.readAsString();
}

Future<String> _getDbPath() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path + 'name.db';
  return path;
}

Future<Database> _getDb() async {
  final path = await _getDbPath();

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT)");
  });
  return database;
}

Future<int> _saveToDb(String name) async {
  final db = await _getDb();
  return db.transaction((txn) {
    txn.rawInsert('INSERT INTO user(name) VALUES("$name")');
  });
}

Future<List<Map>> _getFromDb() async {
  final db = await _getDb();
  List<Map> list = await db.rawQuery('SELECT * FROM user');
  return list;
}

