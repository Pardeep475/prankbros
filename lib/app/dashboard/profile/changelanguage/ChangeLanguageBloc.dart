import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';


class ChangeLanguageBloc {
  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void changeLanguage({String userId, String language,String accessToken, BuildContext context}) {

    debugPrint('userId  :-- $userId    language:--   $language');
    apiRepository.changeLanguage(userId: userId,language: language,accessToken: accessToken).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user email   :        ${onResponse.userDetails.id}");
        SessionManager sessionManager = new SessionManager();
        sessionManager.setUserModel(onResponse.userDetails);
      } else {
        print("Error From Server  " + onResponse.message);
      }
      Utils.showToast(onResponse.message, context);
      Navigator.pop(context);
    }).catchError((onError) {
      print("On_Error" + onError.toString());
      Utils.showToast(onError.toString(), context);
    });
  }

}
