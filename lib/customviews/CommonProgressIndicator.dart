import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/customloaders/ColorLoader.dart';

class CommonProgressIndicator extends StatelessWidget {
  var isLoading = false;

  CommonProgressIndicator(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ColorLoader(
                  colors: [AppColors.pink_stroke],
                  duration: Duration(seconds: 1),
                )))
        : Container(
            height: 0.0,
            width: 0.0,
          );
  }
}
