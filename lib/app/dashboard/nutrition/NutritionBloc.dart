import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class NutritionBloc {
  final BehaviorSubject progressController = BehaviorSubject<int>();

  StreamSink get progressSink => progressController.sink;

  Stream get progressStream => progressController.stream;

  final BehaviorSubject nutritionController =
      BehaviorSubject<NutritionsApiResponse>();

  StreamSink get nutritionSink => nutritionController.sink;

  Stream get nutritionStream => nutritionController.stream;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getNutritions(
      {String userId, String accessToken, BuildContext context}) {
    progressSink.add(0);
    debugPrint('userID  :-- $userId');
    apiRepository
        .getAllNutrition(userId: userId, accessToken: accessToken)
        .then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        ${onResponse}");
        if (onResponse != null) {
//          progressSink.add(1);
          progressSink.add(1);
          nutritionSink.add(onResponse);
        } else {
          progressSink.add(2);
          nutritionSink.add(null);
        }
      } else {
        progressSink.add(2);
        nutritionSink.add(null);
        Utils.showSnackBar(onResponse.message, context);
      }
    }).catchError((onError) {
      progressSink.add(2);
      nutritionSink.add(null);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }
}
