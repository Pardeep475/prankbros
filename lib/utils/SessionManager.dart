import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> pref;

  SessionManager() {
    pref = SharedPreferences.getInstance();
  }

  void setIsLogin(bool isLogin) async {
    pref.then((value) => value.setBool(Keys.IS_LOGIN, isLogin));
  }

  Future<bool> isLogin() {
    return pref.then((value) => value.getBool(Keys.IS_LOGIN));
  }

  void setInstalledFirstTime(bool isInstalledFirstTime) async {
    pref.then((value) {
      value.setBool(Keys.INSTALLED_FIRST_TIME, isInstalledFirstTime);
    });
  }

  Future<bool> isInstalledFirstTime() {
    return pref.then((value) => value.getBool(Keys.INSTALLED_FIRST_TIME));
  }

  void setUserModel(UserData userModel) async {
    pref.then((value) {
      value.setString(Keys.USER_MODEL, json.encode(userModel)).then((value) {
        debugPrint('saving value  $value');
      });
    });
  }

  Future<Map<String, dynamic>> getUserModel() {
    return pref.then((value) {
      if (value.getString(Keys.USER_MODEL) == null) {
        return null;
      } else {
        return json.decode(value.getString(Keys.USER_MODEL));
      }
    });
  }

  void clearAllData() {
    pref.then((value) {
      value.clear();
      setInstalledFirstTime(true);
    });
  }
}
