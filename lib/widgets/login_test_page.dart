import 'package:flutter/material.dart';
import '../network/network.dart';

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
          SizedBox(
            height: 50,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(labelText: "请输入用户名"),
            controller: nameController,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(labelText: "请输入密码"),
            controller: pwdController,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text("注册"),
                onPressed: () {
                  registerTest({
                    "name": this.nameController.text,
                    "pwd": this.pwdController.text
                  }, (data) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(data["message"]),
                          );
                        });
                  });
                },
              ),
              FlatButton(
                child: Text("登录"),
                onPressed: () {
                  loginTest({
                    "name": this.nameController.text,
                    "pwd": this.pwdController.text
                  }, (data) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(data["message"]),
                          );
                        });
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
