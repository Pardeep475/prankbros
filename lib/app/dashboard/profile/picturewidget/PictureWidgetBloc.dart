import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/PictureFinalModel.dart';
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
      BehaviorSubject<List<PictureFinalModel>>();

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

          List<UserProfileImages> userProfileImages = new List();
          userProfileImages.addAll(onResponse.userProfileImages);
          userProfileImages.sort((a, b) {
            return b.createdOnStr.compareTo(a.createdOnStr);
          });

          List<PictureFinalModel> list = new List();

          userProfileImages.forEach((element) {
            PictureFinalModel pictureFinalModel = new PictureFinalModel();
            List<UserProfileImages> _imageProfileList = new List();
            userProfileImages.forEach((item) {
              if (list.length > 0) {
                if (list[list.length - 1].title.compareTo(item.createdOnStr) ==
                    0) {
                  pictureFinalModel.title = item.createdOnStr;
                  _imageProfileList.add(item);
                  userProfileImages.remove(item);
                }
              }else{
                if (_imageProfileList.length > 0) {
                  if (_imageProfileList[_imageProfileList.length - 1]
                      .createdOnStr
                      .compareTo(item.createdOnStr) ==
                      0) {
                    pictureFinalModel.title = item.createdOnStr;
                    _imageProfileList.add(item);
                    userProfileImages.remove(item);
                  }
                } else {
                  pictureFinalModel.title = item.createdOnStr;
                  _imageProfileList.add(item);
                  userProfileImages.remove(item);
                }
              }
            });
            list.add(pictureFinalModel);
            debugPrint(element.createdOnStr);
          });

          weightController.add(list);
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
        getUserProfileImages(userId, context);
      } else {
        Utils.showToast(onResponse.message, context);
      }

//      Utils.showSnackBar(onResponse.message.toString(), context);
    }).catchError((onError) {
      print("On_Error" + onError.toString());
      Utils.showToast(onError.toString(), context);
    });
  }
}
