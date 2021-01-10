import 'dart:convert';
import 'dart:io';
import 'dart:async';

class SocketManage {
  static String host = '192.168.31.106';
  static int port = 6678;
  static Socket mSocket;
  static Stream<List<int>> mStream;
  static bool socketStatus = false;

  static initSocket(void data(bool status)) async {
    await Socket.connect(host, port).then((Socket socket) {
      mSocket = socket;
      socketStatus = true;
      data(socketStatus);
      mStream = mSocket.asBroadcastStream(); //多次订阅的流 如果直接用socket.listen只能订阅一次
    }).catchError((e) {
      print('connectException:$e');
      initSocket(data);
    });
    mSocket.cast<List<int>>().transform(utf8.decoder).listen((data) {
      print(data);
    });
  }

  static void addParams(List<int> params) {
    mSocket.add(params);
  }

  static void dispos() {
    mSocket.close();
  }

  static send(String msg) async {
    mSocket.write(msg);
    // mSocket.add(utf8.encode(msg));
  }
}
