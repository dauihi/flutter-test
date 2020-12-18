import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DataType { section, text, btn, switchBtn, image, number, choose }

DataType getDataTypeFromText(String text) {
  var textArray = [
    "section",
    "text",
    "btn",
    "switchBtn",
    "image",
    "number",
    "choose"
  ];
  int index = textArray.indexOf(text);
  return DataType.values[index];
}

class OriCellData {
  DataType dataType;
  String text;
  String imageName;

  OriCellData({this.dataType, this.text, this.imageName});
}

Future<List<OriCellData>> getOriCellDatas() async {
  List<OriCellData> dataList = List();
  String jsonString = await rootBundle.loadString('assets/data/cell_data.json');
  List<dynamic> jsonResult = json.decode(jsonString);
  for (var i = 0; i < jsonResult.length; i++) {
    Map data = jsonResult[i];
    String dataTypeStr = data["type"].toString();
    DataType dataType = getDataTypeFromText(dataTypeStr);
    dataList.add(new OriCellData(
        dataType: dataType, text: data["text"], imageName: data["imageName"]));
  }
  print(dataList);
  return dataList;
}
