import 'package:flutter/material.dart';
import 'package:prankbros2/utils/Images.dart';

class IntroItemFirst extends StatelessWidget {
  final Color bg;
  final String imageUrl;

  const IntroItemFirst({Key key, this.bg, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(child: Image.asset(Images.Logo)),
    );
  }
}
