import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Food {
  String name;
  double price;

  Food(this.name, this.price);
}

class IsolateTestWidget extends StatefulWidget {
  @override
  _IsolateTestWidgetState createState() => _IsolateTestWidgetState();
}

class _IsolateTestWidgetState extends State<IsolateTestWidget> {
  Isolate isolate;
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
    startBothWay();
    Future.microtask(() {
      print("logo microtask");
    });
  }

  start() async {
    ReceivePort receivePort = ReceivePort();
    isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
    receivePort.listen((data) {
      print('data: $data');
      receivePort.close();
      isolate?.kill(priority: Isolate.immediate);
      isolate = null;
    });
  }

  static getMsg(sendPort) => sendPort.send('hello');

  void startBothWay() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(entryPointBothWay, receivePort.sendPort);
    receivePort.listen((data) {
      if (data is SendPort) {
        data.send('hello child!');
      } else {
        print('parent: $data');
      }
    });
  }

  static void entryPointBothWay(SendPort sendPort) {
    ReceivePort r = ReceivePort();
    sendPort.send(r.sendPort);

    r.listen((data) {
      print('child: $data');
      sendPort.send('hello parent!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
              FlatButton(
                  color: Colors.yellow,
                  onPressed: () async {
                    _count = await compute(asyncCountEven, 1000000);
                    setState(() {});
                  },
                  child: Text(
                    _count.toString(),
                  )),
            ],
          )),
    );
  }

  static Future<int> asyncCountEven(int num) async {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }
}
