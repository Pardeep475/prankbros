import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';

Widget backButton(BuildContext context) {
  return Positioned(
    left: 1,
    top: 12,
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: Dimens.FORTY_FIVE,
        height: Dimens.FORTY_FIVE,
        margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.ten),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(Dimens.THIRTY)),
          ),
          child: Center(
              child: Image.asset(Images.ArrowBackWhite,
                  height: Dimens.fifteen,
                  width: Dimens.twenty,
                  color: AppColors.white)),
        ),
      ),
    ),
  );
}


