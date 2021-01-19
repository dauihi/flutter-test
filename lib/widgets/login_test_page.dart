import 'package:flutter/material.dart';
import '../network/network.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

enum LoginType { login, reigster }

class HomePageTestWidget extends StatefulWidget {
  @override
  _HomePageTestWidgetState createState() => _HomePageTestWidgetState();
}

class _HomePageTestWidgetState extends State<HomePageTestWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "WWater",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                )),
            SizedBox(
              height: mq.size.height - 300,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Water delivery",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "We deliver water We deliver waterWe deliver waterWe deliver waterWe deliver water",
                    style: TextStyle(
                        height: 2,
                        fontSize: 10,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 40,
              width: mq.size.width - 40,
              child: FlatButton(
                color: Colors.white,
                child: Text(
                  "Log in",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return LoginTestWidget(loginType: LoginType.login);
                    },
                  ));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: mq.size.width - 40,
              child: OutlineButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return LoginTestWidget(loginType: LoginType.reigster);
                    },
                  ));
                },
                borderSide: BorderSide(color: Colors.white, width: 1),
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginTestWidget extends StatefulWidget {
  final LoginType loginType;

  const LoginTestWidget({@required this.loginType});

  @override
  _LoginTestWidgetState createState() => _LoginTestWidgetState();
}

class _LoginTestWidgetState extends State<LoginTestWidget> {
  LoginType loginType;
  double keyBoardPad = 150;
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;
  bool showPwd = true;
  bool showNameRight = false;
  bool showEmailRight = false;

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final String regexEmail =
      "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// 检查是否是邮箱格式
  bool isEmail(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  login(BuildContext context) {
    loginTest(
        {"email": this.emailController.text, "pwd": this.pwdController.text},
        (data) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(data["message"]),
            );
          });
    });
  }

  register(BuildContext context) {
    registerTest({
      "email": this.emailController.text,
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loginType = this.widget.loginType;

    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
          if (visible) {
            this.keyBoardPad = 10;
          } else {
            this.keyBoardPad = 150;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_left),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            this.loginType == LoginType.login
                                ? "Welcome"
                                : "Create",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        )),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            this.loginType == LoginType.login
                                ? "Back"
                                : "Account",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        )),
                    SizedBox(
                      height: this.keyBoardPad,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: this.loginType == LoginType.login ? 80 : 20,
              ),
              Visibility(
                visible: this.loginType == LoginType.login ? false : true,
                child: SizedBox(
                  height: 40,
                  width: mq.size.width - 40,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.face),
                        suffixIcon: showNameRight ? Icon(Icons.done) : null),
                    controller: nameController,
                    onChanged: (v) {
                      if (v.trim().length > 0) {
                        showNameRight = true;
                      } else {
                        showNameRight = false;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: this.loginType == LoginType.login ? 0 : 20,
              ),
              SizedBox(
                height: 40,
                width: mq.size.width - 40,
                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      hintText: "water@gmail.com",
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: showEmailRight ? Icon(Icons.done) : null),
                  controller: emailController,
                  onChanged: (v) {
                    if (v.trim().length > 0 && isEmail(v.trim())) {
                      showEmailRight = true;
                    } else {
                      showEmailRight = false;
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: mq.size.width - 40,
                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: this.showPwd
                            ? Icon(Icons.gps_fixed)
                            : Icon(Icons.gps_off),
                        onPressed: () {
                          setState(() {
                            this.showPwd = !this.showPwd;
                          });
                        },
                      )),
                  controller: pwdController,
                  obscureText: !this.showPwd,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                  visible: this.loginType == LoginType.login ? true : false,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: mq.size.width - 40,
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    this.loginType == LoginType.login ? "Log in" : "Sign up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (this.emailController.text.length == 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("email不能为空"),
                            );
                          });
                      return;
                    }
                    if (!isEmail(this.emailController.text)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("email格式不对"),
                            );
                          });
                      return;
                    }
                    if (this.pwdController.text.length == 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("password不能为空"),
                            );
                          });
                      return;
                    }
                    if (this.loginType == LoginType.login) {
                      login(context);
                    } else {
                      if (this.nameController.text.length == 0) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("用户名不能为空"),
                              );
                            });
                        return;
                      }
                      register(context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: mq.size.width - 40,
                height: 20,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: (mq.size.width - 70) / 2.0,
                        height: 1,
                        child: Opacity(
                          opacity: 0.3,
                          child: Container(
                            color: Colors.grey,
                          ),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: (mq.size.width - 70) / 2.0,
                      height: 1,
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                width: mq.size.width - 40,
                child: OutlineButton(
                  onPressed: () {
                    if (this.loginType == LoginType.login) {
                      this.loginType = LoginType.reigster;
                    } else {
                      this.loginType = LoginType.login;
                    }
                    setState(() {});
                  },
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  child: Text(
                    this.loginType == LoginType.login ? "Sign up" : "Log in",
                    style: TextStyle(color: Colors.grey),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }
}
