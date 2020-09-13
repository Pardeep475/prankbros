import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/MotivationHistoryModel.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc {
  // 0 for progressbar, 1 for main item, 2 for item not found
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  //final PublishSubject<List<MotivationHistoryItem>> weightController = PublishSubject<List<MotivationHistoryItem>>();

  Stream<List<MotivationHistoryItem>> get weightStream => weightSink.stream;
  List<MotivationHistoryItem> Weightlist=[];
  PublishSubject<List<MotivationHistoryItem>>  weightSink =  PublishSubject<List<MotivationHistoryItem>>();

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getMotivationActivation(
      {String userId, String trainingWeek,String accessToken, BuildContext context}) {
    debugPrint('userID  :-- $userId');
    progressSink.add(0);
    Weightlist=[];
    apiRepository
        .getMotivationActivation(userId: userId, trainingWeek: trainingWeek,accessToken: accessToken)
        .then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
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
              isSelected: Utils.checkCurrentDate(
                  onResponse.workoutActivities[i].createdOnStr)));
          debugPrint(
              'date  :   ${_list[i].date}   week  :   ${_list[i].weekDay}   name:   ${_list[i].title}    isselected:   ${_list[i].isSelected}');
        }
        progressSink.add(1);

        Weightlist.addAll(_list);
        weightSink.sink.add(_list);
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

  void getMotivationActivationStart(
      MotivationApiResponse motivationData, BuildContext context) {
    progressSink.add(0);

    List<MotivationHistoryItem> _list = new List();

    try {
      if (motivationData == null ||
          motivationData.workoutActivities == null ||
          motivationData.workoutActivities.length <= 0) {
        progressSink.add(2);
        Utils.showSnackBar("Something went wrong", context);
      } else {
        for (int i = 0; i < motivationData.workoutActivities.length; i++) {
          debugPrint(
              "date   :        ${motivationData.workoutActivities[i].createdOnStr}");

          _list.add(MotivationHistoryItem(
              date: Utils.getMonthFromDate(
                  motivationData.workoutActivities[i].createdOnStr),
              weekDay: Utils.getMonthFromDay(
                  motivationData.workoutActivities[i].createdOnStr),
              title: motivationData.workoutActivities[i].workoutName,
              isSelected: Utils.checkCurrentDate(
                  motivationData.workoutActivities[i].createdOnStr)));
          debugPrint(
              'date  :   ${_list[i].date}   week  :   ${_list[i].weekDay}   name:   ${_list[i].title}    isselected:   ${_list[i].isSelected}');
        }
        progressSink.add(1);
        Weightlist.addAll(_list);
        weightSink.sink.add(_list);
      }
    } catch (e) {
      progressSink.add(2);
      print("On_Error" + e.toString());
      Utils.showSnackBar(e.toString(), context);
    }
  }
}
