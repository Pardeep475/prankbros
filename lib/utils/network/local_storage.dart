import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static final String _userId = "userId";

  static final String _profileId = "profileId";

  static final String _userName = "userName";

  static final String _authToken = "authToken";

  static final String _profileDetail = "profileDetail";


  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userName) ?? '';
  }

  static Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userName, value);

  } static Future<String> getUserAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_authToken) ?? '';
  }

  static Future<bool> setUserAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_authToken, value);
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userId) ?? '';
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userId, value);
  }
  static Future<String> getUserProfilId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_profileId) ?? '';
  }

  static Future<bool> setUserProfileId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_profileId, value);
  }

  static Future<String> getProfileDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_profileDetail) ?? '';
  }

  static Future<bool> setProfileDetail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_profileDetail, value);
  }

  static Future<bool> clearAllPreferncesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(_userId);
    preferences.remove(_userName);
    preferences.remove(_profileId);
    preferences.remove(_authToken);
    preferences.clear();
  }
}
