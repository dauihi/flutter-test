import 'package:flutter/material.dart';

class StepperTestWidget extends StatefulWidget {
  @override
  _StepperTestWidgetState createState() => _StepperTestWidgetState();
}

class _StepperTestWidgetState extends State<StepperTestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        steps: [
          Step(
              title: Text('Step 标题一'),
              subtitle: Text('Step 副标题一'),
              content: Container(
                color: Colors.orangeAccent.withOpacity(0.4),
                child: Text('Step 内容一'),
              )),
          Step(
              title: Text('Step 标题二'),
              subtitle: Text('Step 副标题二'),
              content: Container(
                color: Colors.blue.withOpacity(0.3),
                child: Text('Step 内容二'),
              ))
        ],
      ),
    );
  }
}

class BuildTestPage extends StatelessWidget {
  var clickTimes = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: GestureDetector(
              child: Text("clickTimes$clickTimes"),
              onTap: () {
                setState(() {
                  clickTimes++;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
