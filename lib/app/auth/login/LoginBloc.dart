import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final BehaviorSubject progressController = BehaviorSubject<bool>();

  Stream get progressStream => progressController.stream;

  StreamSink get progressSink => progressController.sink;

  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void doLogin(String email, String password, BuildContext context) {
    progressSink.add(true);
    debugPrint('email  :-- $email    password:--   $password');
    apiRepository.login(email, password).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint(
            "Here is user email   :        ${onResponse.userDetails.id}");
        SessionManager sessionManager = new SessionManager();
        sessionManager.setUserModel(onResponse.userDetails);
        sessionManager.getUserModel().then((value) {
          debugPrint("userdata   :        ${value}");
          if (value != null) {
            UserDetails userData = UserDetails.fromJson(value);
            debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
          }
        });
        sessionManager.setIsLogin(true);
        Navigator.pushNamedAndRemoveUntil(
            context, Strings.DASHBOARD_ROUTE, (route) => false);
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

  void getUserDetails(
      {String userId, String accessToken, BuildContext context}) {
    progressSink.add(true);
    debugPrint('userID  :-- $userId');
    apiRepository
        .getUserDetails(userId: userId, accessToken: accessToken)
        .then((onResponse) {
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
