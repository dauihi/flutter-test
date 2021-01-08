import 'package:flutter/material.dart';
import '../network/network.dart';
import '../model/network_test_model.dart';
import '../network/socket.dart';

class NetworkTestWidget extends StatefulWidget {
  @override
  _NetworkTestWidgetState createState() => _NetworkTestWidgetState();
}

class _NetworkTestWidgetState extends State<NetworkTestWidget> {
  var text = "";

  @override
  void initState() {
    // TODO: implement initState
    connect();

    // getDataByDio().then((result) {
    //   setState(() {
    //     text = result;
    //   });
    // });

    // postDataByDio({"a": 1, "b": 2}).then((result) {
    //   PostTestResponseModel model = PostTestResponseModel.fromJson(result);
    //   if (model.code == 200) {
    //     setState(() {
    //       text = model.data.toString();
    //     });
    //   }
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
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
