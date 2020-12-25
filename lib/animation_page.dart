import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';

class AnimationContainerPage extends StatefulWidget {
  @override
  _AnimationContainerPageState createState() => _AnimationContainerPageState();
}

class _AnimationContainerPageState extends State<AnimationContainerPage> {
  double size = 100;
  double radius = 25;
  Color color = Colors.yellow;

  _animate() {
    setState(() {
      size = size == 100 ? 200 : 100;
      radius = radius == 25 ? 100 : 25;
      color = color == Colors.yellow ? Colors.black : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('base test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: size,
              height: size,
              curve: Curves.easeIn,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
              duration: Duration(seconds: 1),
              child: FlutterLogo(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animate();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class OpacityChangePage extends StatefulWidget {
  @override
  _OpacityChangePageState createState() => _OpacityChangePageState();
}

class _OpacityChangePageState extends State<OpacityChangePage> {
  double _opacity = 1.0;

  _toggle() {
    _opacity = _opacity > 0 ? 0.0 : 1.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('隐式动画'),
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggle();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class RotationAnimationPage extends StatefulWidget {
  @override
  _RotationAnimationPageState createState() => _RotationAnimationPageState();
}

class _RotationAnimationPageState extends State<RotationAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _turns;
  bool _playing = false;

  void _toggle() {
    if (_playing) {
      _playing = false;
      _controller.stop();
    } else {
      _controller.forward()..whenComplete(() => _controller.reverse());
      _playing = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _turns = Tween(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('显示动画'),
      ),
      body: Center(
        child: RotationTransition(
          turns: _turns,
          child: Container(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/images/football_check.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggle();
        },
        child: Icon(_playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

class StaggeredAnimationPage extends StatefulWidget {
  @override
  _StaggeredAnimationPageState createState() => _StaggeredAnimationPageState();
}

class _StaggeredAnimationPageState extends State<StaggeredAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _width;
  Animation<double> _height;
  Animation<Color> _color;
  Animation<double> _border;
  Animation<BorderRadius> _borderRadius;

  void _play() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _width = Tween<double>(begin: 100, end: 300).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.2, curve: Curves.ease)));

    _height = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.2, 0.4, curve: Curves.ease)));

    _color = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.4, 0.6, curve: Curves.ease)));

    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(150.0),
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.6, 0.8, curve: Curves.ease)));

    _border = Tween<double>(
      begin: 0,
      end: 25,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.8, 1.0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('交织动画'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: _width.value,
              height: _height.value,
              decoration: BoxDecoration(
                  color: _color.value,
                  borderRadius: _borderRadius.value,
                  border:
                      Border.all(width: _border.value, color: Colors.orange)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _play();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ThrowAnimationPage extends StatefulWidget {
  @override
  _ThrowAnimationPageState createState() => _ThrowAnimationPageState();
}

class _ThrowAnimationPageState extends State<ThrowAnimationPage> {
  double y = 70.0;
  double vy = -10.0;
  double gravity = 0.1;
  double bounce = -0.5;
  double radius = 50.0;
  final double height = 700;

  _fall(_) {
    y += vy;
    vy += gravity;

    if (y + radius > height) {
      y = height - radius;
      vy *= bounce;
    } else if (y - radius < 0) {
      y = 0 + radius;
      vy *= bounce;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Ticker(_fall)..start();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('物理动画'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: y - radius,
                  left: screenWidth / 2 - radius,
                  child: Container(
                    width: radius * 2,
                    height: radius * 2,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationState;
  double animationValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationState = status;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Text(
              'Start',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(
            'State:' + animationState.toString(),
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            'Value:' + animationValue.toString(),
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: animation.value,
            width: animation.value,
            child: FlutterLogo(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
