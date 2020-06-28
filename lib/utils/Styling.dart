import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';


ThemeData appTheme = new ThemeData(
    hintColor: AppColors.pink_stroke,
    accentColor: AppColors.blue,
    backgroundColor: AppColors.white,
    primaryColor: AppColors.primary_color);

Color textFieldColor = const Color.fromRGBO(255, 255, 255, 0.1);

TextStyle buttonTextStyle = const TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 0.8),
    fontSize: 14.0,
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold);

TextStyle textStyle = const TextStyle(
    color: const Color(0XFFFFFFFF),
    fontSize: 16.0,
    fontWeight: FontWeight.normal);
