import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/PictureFinalModel.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class MotivationBloc {
  // 0 for progressbar, 1 for main item, 2 for item not found
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  final BehaviorSubject weightController =
      BehaviorSubject<MotivationApiResponse>();

  Stream get weightStream => weightController.stream;

  StreamSink get weightSink => weightController.sink;

  final BehaviorSubject weekController = BehaviorSubject<String>();

  Stream get weekStream => weekController.stream;

  StreamSink get weekSink => weekController.sink;

  final BehaviorSubject workoutController = BehaviorSubject<String>();

  Stream get workoutStream => workoutController.stream;

  StreamSink get workoutSink => workoutController.sink;

  final BehaviorSubject motivationController = BehaviorSubject<String>();

  Stream get motivationStream => motivationController.stream;

  StreamSink get motivationSink => motivationController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getMotivation({String userId, String accessToken, BuildContext context}) {
    debugPrint('userID  :-- $userId');
    progressSink.add(0);
    apiRepository
        .getMotivation(userId: userId, accessToken: accessToken)
        .then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
        progressSink.add(1);
        weightController.add(onResponse);
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
}
