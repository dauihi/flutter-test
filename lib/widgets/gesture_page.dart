import 'package:flutter/material.dart';

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  _GestureDetectorTestRouteState createState() =>
      new _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!";

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("GestureDetectorTest"),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200.0,
            height: 200.0,
            child: Text(
              _operation,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ),
          onTap: () => updateText("onTap"),
          onDoubleTap: () => updateText("onDoubleTap"),
          onLongPress: () => updateText("onLongPress"),
        ),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightGreen,
      duration: Duration(microseconds: 400),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class DragTest extends StatefulWidget {
  @override
  _DragTestState createState() => new _DragTestState();
}

class _DragTestState extends State<DragTest>
    with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('DragTest'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text(
                  "Draggable Text",
                  textAlign: TextAlign.center,
                ),
                radius: 50,
              ),
              onPanDown: (DragDownDetails e) {
                print("用户手指按下 ${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ScaleTestRoute extends StatefulWidget {
  @override
  _ScaleTestRouteState createState() => new _ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: GestureDetector(
        child: Image.asset(
          'assets/images/football_check.png',
          width: _width,
        ),
        onScaleUpdate: (ScaleUpdateDetails detail) {
          setState(() {
            _width = 200 * detail.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class DismissibleWidget extends StatelessWidget {
  final List<String> items;

  DismissibleWidget({@required this.items});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismiss 示例'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              items.removeAt(index);
              print(index);
            },
            child: ListTile(
              leading: Icon(Icons.access_time),
              title: Text('${items[index]}'),
            ),
          );
        },
      ),
    );
  }
}
