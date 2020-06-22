import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc {
  Stream get progressStream => progressController.stream;

  final BehaviorSubject progressController = BehaviorSubject<bool>();

  StreamSink get progressSink => progressController.sink;
  ApiRepository apiRepository = ApiRepository();
  AppConstantHelper helper = AppConstantHelper();

  void doForgotPassword(String email, BuildContext context) {
    progressSink.add(true);
    debugPrint('email  :-- $email    password:--   $email');
    apiRepository.forgotPassword(email).then((onResponse) {
      if (onResponse.status == 1) {
        debugPrint("Here is user email   :        $email");
        Navigator.pushNamed(context, Strings.SEND_EMAIL_ROUTE);
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
