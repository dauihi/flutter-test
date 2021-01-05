import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

getData() async {
  String url = "http://192.168.31.106:80/test/index.php";
  Dio dio = new Dio();
  Response response = await dio.get(url);
  var data = response.data;
  return data;
}
