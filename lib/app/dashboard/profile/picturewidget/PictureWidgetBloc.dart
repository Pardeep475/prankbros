import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class PictureWidgetBloc {
  // 0 for progressbar, 1 for main item, 2 for item not found
  final BehaviorSubject progressController = BehaviorSubject<int>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  final BehaviorSubject weightController =
  BehaviorSubject<List<UserProfileImages>>();

  Stream get weightStream => weightController.stream;

  StreamSink get weightSink => weightController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void getUserProfileImages(String userId, BuildContext context) {
    debugPrint('userID  :-- $userId');
    progressSink.add(0);
    apiRepository.getUserProfileImages(userId: userId).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user id   :        $userId");
        if (onResponse.userProfileImages != null &&
            onResponse.userProfileImages.length > 0) {
          progressSink.add(1);
          weightController.add(onResponse.userProfileImages);
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

  void addUserProfileImages(String userId, String path, BuildContext context) {
    debugPrint('userID  :-- $userId');
    apiRepository
        .addUserProfileImage(userId: userId, path: path)
        .then((onResponse) {
      debugPrint('add metjod--->   ${onResponse.toJson()}');
      if (onResponse == null) {
        return;
      }

      if (onResponse.status == 1) {
        getUserProfileImages(userId,context);
      } else {
        Utils.showToast(onResponse.message,context);
      }

//      Utils.showSnackBar(onResponse.message.toString(), context);
    }).catchError((onError) {
      print("On_Error" + onError.toString());
      Utils.showToast(onError.toString(),context);
    });
  }
}
