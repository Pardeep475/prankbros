import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/customloaders/ColorLoader.dart';

class CommonProgressIndicator extends StatelessWidget {
  var isLoading = false;

  CommonProgressIndicator(this.isLoading);

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:  AppColors.pink_stroke,
          ),
        );
      },
    );
    return isLoading
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: spinkit))
        : Container(
            height: 0.0,
            width: 0.0,
          );
  }
}
