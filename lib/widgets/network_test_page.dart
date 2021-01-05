import 'package:flutter/material.dart';
import '../network/network.dart';

class NetworkTestWidget extends StatefulWidget {
  @override
  _NetworkTestWidgetState createState() => _NetworkTestWidgetState();
}

class _NetworkTestWidgetState extends State<NetworkTestWidget> {
  var text = "";

  @override
  void initState() {
    // TODO: implement initState
    getData().then((result) {
      setState(() {
        text = result;
      });
    });
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
