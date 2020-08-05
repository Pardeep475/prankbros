import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/nutrition/NutritionActionModel.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class NutritionDetailBloc {
  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;

  Stream get progressStream => progressController.stream;

  final BehaviorSubject nutritionController = BehaviorSubject<bool>();

  StreamSink get nutritionSink => nutritionController.sink;

  Stream get nutritionStream => nutritionController.stream;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void nutritionActionModel(
      {NutritionActionModel nutritionActionModel,
      String accessToken,
      BuildContext context}) {
    progressSink.add(true);
    debugPrint('userID  :-- ${nutritionActionModel.userId}');
    apiRepository
        .actionFavNutrition(
            nutritationModel: nutritionActionModel, accessToken: accessToken)
        .then((onResponse) {
      if (onResponse.status == 1) {
        nutritionSink.add(true);
      } else {
        nutritionSink.add(false);
      }
      Utils.showSnackBar(onResponse.message, context);
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      nutritionSink.add(false);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }
}
