import 'dart:convert';
import 'dart:io';
import 'dart:async';

Socket theSocket;

connect() async {
  String host = '192.168.31.106';
  int port = 6678;

  Socket theSocket = await Socket.connect(host, port);
  theSocket.write("客户端连接");
  theSocket.cast<List<int>>().transform(utf8.decoder).listen(print);
}

write(String message) async {
  theSocket.write("message");
}
