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

    }
    );
  }

  Future<bool> isInstalledFirstTime() {
    return pref.then((value) => value.getBool(Keys.INSTALLED_FIRST_TIME));
  }
}
