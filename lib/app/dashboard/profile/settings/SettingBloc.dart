import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class SettingBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();
  StreamSink get progressSink => progressController.sink;
  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void resetYourProgram(
      String userId, String trainingWeek, BuildContext context) {
    debugPrint('userId  :-- $userId    trainingWeek:--   $trainingWeek');
    apiRepository.resetYourProgram(userId, trainingWeek).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user email   :        ${onResponse.message}");
        Utils.showSnackBar(onResponse.message, context);
      } else {
        Utils.showSnackBar(onResponse.message, context);
      }
      Navigator.pop(context);
    }).catchError((onError) {
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
      Navigator.pop(context);
    });
  }

  void getUserDetails(String userId, BuildContext context) {
    progressSink.add(true);
    debugPrint('userID  :-- $userId');
    apiRepository.getUserDetails(userId).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
        SessionManager sessionManager = new SessionManager();
        sessionManager.setUserModel(onResponse.userDetails);
      } else {
        print("Error From Server  " + onResponse.message);
        Utils.showSnackBar(onResponse.message, context);
      }
      progressSink.add(false);
    }).catchError((onError) {
      progressSink.add(false);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }
}
