import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class UpdateProfileBloc {
  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  Future<bool> updateUserProfile(String userId, String firstName,
      String lastName, String email, BuildContext context) async {
    debugPrint(
        'userId  :-- $userId    firstName:--   $firstName  lastName:--   $lastName  email---:   $email');
    var onResponse = await apiRepository.updateUserProfile(
        userId, firstName, lastName, email);
    try {
      if (onResponse.status == 1) {
        debugPrint(
            "Here is user email   :        ${onResponse.userDetails.id}");
        SessionManager sessionManager = new SessionManager();
        sessionManager.setUserModel(onResponse.userDetails);
        if (onResponse.emailUpdateMessage != null)
          Utils.showToast(onResponse.emailUpdateMessage, context);
        else
          Utils.showToast(onResponse.message, context);
      } else {
        print("Error From Server  " + onResponse.message);
        Utils.showToast(onResponse.message, context);
      }
      return false;
    } catch (e) {
      print("On_Error" + e.toString());
      Utils.showToast(e.toString(), context);
      return false;
    }
  }
}
