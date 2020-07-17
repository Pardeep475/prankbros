import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class NutritionBloc {
  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get progressStream => progressController.stream;

  final BehaviorSubject nutritionController =
      BehaviorSubject<NutritionsApiResponse>();

  StreamSink get nutritionSink => nutritionController.sink;

  Stream get nutritionStream => nutritionController.stream;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getNutritions(String userId, BuildContext context) {
    progressSink.add(true);
    debugPrint('userID  :-- $userId');
    apiRepository.getAllNutrition(userId).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        ${onResponse}");
        if (onResponse != null)
          nutritionSink.add(onResponse);
        else
          nutritionSink.add(null);
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
