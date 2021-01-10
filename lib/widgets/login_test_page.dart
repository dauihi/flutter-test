import 'package:flutter/material.dart';

class LoginTestWidget extends StatefulWidget {
  @override
  _LoginTestWidgetState createState() => _LoginTestWidgetState();
}

class _LoginTestWidgetState extends State<LoginTestWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: pwdController,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text("注册"),
                onPressed: () {},
              ),
              FlatButton(
                child: Text("登录"),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
