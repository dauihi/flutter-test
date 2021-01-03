import 'package:flutter/material.dart';

import 'hero_animation_page2.dart';

String cake1 = 'assets/images/football_check.png';
String cake2 = 'assets/images/basketball_check.png';

class HeroAnimationPage1 extends StatelessWidget {
  GestureDetector buildRowItem(context, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return HeroAnimationPage2(image: image);
          },
        ));
      },
      child: Container(
        width: 100,
        height: 100,
        child: Hero(
          tag: image,
          child: ClipOval(child: Image.asset(image)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('页面1')),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildRowItem(context, cake1),
              buildRowItem(context, cake2),
            ],
          )
        ],
      ),
    );
  }
}
