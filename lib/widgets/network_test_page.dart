import 'package:flutter/material.dart';
import '../network/network.dart';
import '../model/network_test_model.dart';
import '../network/socket.dart';

class NetworkTestWidget extends StatefulWidget {
  @override
  _NetworkTestWidgetState createState() => _NetworkTestWidgetState();
}

class _NetworkTestWidgetState extends State<NetworkTestWidget> {
  var connectStateText = "未连接";
  TextEditingController textEditController = TextEditingController();

  @override
  void initState() {
    SocketManage.initSocket((status) {
      if (status) {
        setState(() {
          connectStateText = "已连接";
          SocketManage.send("好的");
        });
      }
    });
    // TODO: implement initStat

    // getDataByDio().then((result) {
    //   setState(() {
    //     text = result;
    //   });
    // });

    // loginTest({"action": "login", "name": "ffe", "pwd": '123'}).then((result) {
    //   print(result);
    // });

    // getDataByOri().then((result) {
    //   setState(() {
    //     text = result;
    //   });
    // });
    // postDataByOri({"a": "1", "b": "2"}).then((result) {
    //   print(result);
    // });

    // getDataByHttp().then((result) {
    //   setState(() {
    //     text = result;
    //   });
    // });

    // postDataByHttp({"a": "1", "b": "2"}).then((result) {
    //   PostTestResponseModel model = PostTestResponseModel.fromJson(result);
    //   if (model.code == 200) {
    //     setState(() {
    //       text = model.data.toString();
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                this.connectStateText,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          TextField(
            controller: textEditController,
          ),
          FlatButton(
            child: Text("发送"),
            color: Colors.blue,
            onPressed: () {
              // send();
              SocketManage.send(textEditController.text);
            },
          )
        ],
      ),
    );
  }
}
