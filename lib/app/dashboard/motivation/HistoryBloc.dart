import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/MotivationHistoryModel.dart';
import 'package:prankbros2/models/motivation/MotivationActivityApiResponse.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc {
  // 0 for progressbar, 1 for main item, 2 for item not found
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  final BehaviorSubject weightController =
      BehaviorSubject<List<MotivationHistoryItem>>();

  Stream get weightStream => weightController.stream;

  StreamSink get weightSink => weightController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getMotivationActivation(
      String userId, String trainingWeek, BuildContext context) {
    debugPrint('userID  :-- $userId');
    progressSink.add(0);
    apiRepository
        .getMotivationActivation(userId: userId, trainingWeek: trainingWeek)
        .then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
//        progressSink.add(1);
//        weightController.add(onResponse.workoutActivities);
        List<MotivationHistoryItem> _list = new List();

        for (int i = 0; i < onResponse.workoutActivities.length; i++) {
          debugPrint(
              "date   :        ${onResponse.workoutActivities[i].createdOnStr}");

          _list.add(MotivationHistoryItem(
              date: Utils.getMonthFromDate(
                  onResponse.workoutActivities[i].createdOnStr),
              weekDay: Utils.getMonthFromDay(
                  onResponse.workoutActivities[i].createdOnStr),
              title: onResponse.workoutActivities[i].workoutName,
              isSelected: false));
          debugPrint(
              'date  :   ${_list[i].date}   week  :   ${_list[i].weekDay}   name:   ${_list[i].title}    isselected:   ${_list[i].isSelected}');
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
}
