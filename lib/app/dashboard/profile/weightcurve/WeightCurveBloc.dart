import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WeightCurveBloc {
  // 0 for progressbar, 1 for main item, 2 for item not found
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  final BehaviorSubject weightController =
      BehaviorSubject<List<UserProfileWeights>>();

  Stream get weightStream => weightController.stream;

  StreamSink get weightSink => weightController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getWeightCurve({String userId,String accessToken, BuildContext context}) {
    debugPrint('userID  :-- $userId');
    progressSink.add(0);
    apiRepository.getUserWeight(userId: userId,accessToken: accessToken).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
        if (onResponse.userProfileWeights != null &&
            onResponse.userProfileWeights.length > 0) {
          progressSink.add(1);
          weightController.add(onResponse.userProfileWeights);
        } else {
          progressSink.add(2);
        }
      } else {
        progressSink.add(2);
        print("Error From Server  " + onResponse.message);
        Utils.showSnackBar(onResponse.message, context);
      }
    }).catchError((onError) {
      progressSink.add(2);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }

  void addWeightCurve({String userId, String widget,String createdOn,String accessToken, BuildContext context}) {
    debugPrint('userID  :-- $userId');
    apiRepository
        .addUserWeight(userId: userId, weight: widget,createdOn :createdOn,accessToken: accessToken)
        .then((onResponse) {
      debugPrint('add metjod--->   ${onResponse.toJson()}');
      if (onResponse == null) {
        return;
      }
      Utils.showToast(onResponse.message,context);
      if (onResponse.status == 1) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }

//      Utils.showSnackBar(onResponse.message.toString(), context);
    }).catchError((onError) {
      print("On_Error" + onError.toString());
      Utils.showToast(onError.toString(),context);
      Navigator.pop(context);
    });
  }
}
