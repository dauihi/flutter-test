import 'package:flutter/material.dart';

class TextFieldTestWidget extends StatefulWidget {
  @override
  _TextFieldTestWidgetState createState() => _TextFieldTestWidgetState();
}

class _TextFieldTestWidgetState extends State<TextFieldTestWidget> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("SqliteOperator"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                focusNode: focusNode1,
                decoration: InputDecoration(labelText: "输入1"),
              ),
              TextField(
                autofocus: true,
                focusNode: focusNode2,
                decoration: InputDecoration(labelText: "输入2"),
              ),
              Builder(
                builder: (context) {
                  return Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("移动焦点"),
                        onPressed: () {
                          if (focusScopeNode == null) {
                            focusScopeNode = FocusScope.of(context);
                          }
                          focusScopeNode.requestFocus(focusNode2);
                        },
                      ),
                      RaisedButton(
                        child: Text("隐藏键盘"),
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}

class FormTestWidget extends StatefulWidget {
  @override
  _FormTestWidgetState createState() => _FormTestWidgetState();
}

class _FormTestWidgetState extends State<FormTestWidget> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Text"),
        ),
        body: new Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名",
                        icon: Icon(Icons.person)),
                    validator: (v) {
                      return v.trim().length > 0 ? null : "用户名不能为空";
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: _pwdController,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "登录密码",
                        icon: Icon(Icons.lock)),
                    validator: (v) {
                      return v.trim().length > 5 ? null : "密码不能少于6";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            child: Text("登录"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text("数据可提交"),
                                ));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
