import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class NutritionBloc {

  final BehaviorSubject progressController = BehaviorSubject<bool>();
  StreamSink get progressSink => progressController.sink;
  Stream get progressStream => progressController.stream;

  final BehaviorSubject nutritionController = BehaviorSubject<List<AllNutritions>>();
  StreamSink get nutritionSink => nutritionController.sink;
  Stream get nutritionStream => nutritionController.stream;


  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getNutritions(String userId, BuildContext context) {
    progressSink.add(true);
    debugPrint('userID  :-- $userId');
    apiRepository.getAllNutrition(userId).then((onResponse) {
      if (onResponse.status == 1 && onResponse.allNutritions != null && onResponse.allNutritions.length>0) {
        debugPrint("Here is user id   :        ${onResponse.allNutritions.length}");;
        nutritionSink.add(onResponse.allNutritions);
      } else {
        nutritionSink.add(null);
        Utils.showSnackBar(onResponse.message, context);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      nutritionSink.add(null);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }
}
