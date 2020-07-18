import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/Images.dart';

class BackgroundWidgetWithImage extends StatelessWidget {
  String imagePath;
  Color curveColor;

  BackgroundWidgetWithImage({this.imagePath, this.curveColor});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        FadeInImage(
            height: MediaQuery.of(context).size.height / 2.7,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
            placeholder: AssetImage(Images.DummyFood)),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: CurvePainter(curveColor: curveColor),
          ),
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  Color curveColor;

  CurvePainter({this.curveColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = curveColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.25);

    path.quadraticBezierTo(size.width * 0.02, size.height * 0.32,
        size.width * .2, size.height * 0.32);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.32,
        size.width * .8, size.height * 0.32);
    path.quadraticBezierTo(size.width * .98, size.height * 0.32, size.width * 1,
        size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
