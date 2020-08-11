import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WorkoutDetailBloc {
  // 0 for progress bar 1 for content 2 for error
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  final BehaviorSubject contentController = BehaviorSubject<GetUserTrainingResponseApi>();

  Stream get contentStream => contentController.stream;

  StreamSink get contentSink => contentController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getWorkoutDetail(
      {String screenType,
      String trainingWeek,
      String influencerId,
      String accessToken,
      BuildContext context}) {
    progressSink.add(0);
    apiRepository
        .getUserTraining(
            screenType: screenType,
            trainingWeek: trainingWeek,
            influencerId: influencerId,
            accessToken: accessToken)
        .then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("value comes");
        progressSink.add(1);
        contentSink.add(onResponse);
      } else {
        print("Error From Server  " + onResponse.message);
        progressSink.add(2);
        Utils.showSnackBar(onResponse.message, context);
      }
    }).catchError((onError) {
      progressSink.add(2);
      print("On_Error" + onError.toString());
      Utils.showSnackBar(onError.toString(), context);
    });
  }
}