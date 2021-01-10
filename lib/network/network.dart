import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

final String postTestUrl = "http://192.168.31.106:80/test/posttest.php";
final String loginTestUrl = "http://192.168.31.106:80/test/logintest.php";

getDataByDio() async {
  String url = "http://192.168.1.6:80/test/index.php";
  Dio dio = new Dio();
  Response response = await dio.get(url);
  var data = response.data;
  return data;
}

postDataByDio(String url, Map<String, dynamic> map) async {
  Dio dio = new Dio();
  FormData formData = FormData.fromMap(map);
  Response response = await dio.post(url, data: formData);
  var result = response.data;
  return jsonDecode(result);
}

getDataByOri() async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri(
      scheme: "http",
      host: "192.168.31.106",
      port: 80,
      path: "/test/index.php",
      queryParameters: {}));
  HttpClientResponse response = await request.close();
  var content = await response.transform(Utf8Decoder()).join();
  httpClient.close();
  return content;
}

// postDataByOri(Map<String, dynamic> map) async {
//   HttpClient httpClient = new HttpClient();
//   HttpClientRequest request = await httpClient.postUrl(Uri(
//       scheme: "http",
//       host: "192.168.31.106",
//       port: 80,
//       path: "/test/posttest.php"));
//   request.headers.set("isEncoded", "1");
//   request.headers.set('content-type', 'application/json');
//   request.add(utf8.encode(json.encode(map)));

//   HttpClientResponse response = await request.close();
//   var content = await response.transform(Utf8Decoder()).join();
//   httpClient.close();
//   return content;
// }

// getDataByHttp() async {
//   String url = "http://192.168.31.106:80/test/index.php";
//   var client = http.Client();
//   http.Response response = await client.get(url);
//   var content = response.body;
//   return content;
// }

// postDataByHttp(Map<String, dynamic> map) async {
//   String url = "http://192.168.31.106:80/test/posttest.php";
//   var client = http.Client();
//   var response = await client.post(url, body: map);
//   var content = response.body;
//   return jsonDecode(content);
// }

loginTest(Map<String, dynamic> map, void data(data)) async {
  map["action"] = "login";
  var result = await postDataByDio(loginTestUrl, map);
  data(result);
}

registerTest(Map<String, dynamic> map, void data(data)) async {
  map["action"] = "register";
  var result = await postDataByDio(loginTestUrl, map);
  data(result);
}
