import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/CommonResponse.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/network/AppConstantHelper.dart';

import '../Strings.dart';
import 'local_storage.dart';
import 'LoggingInterceptor.dart';

class ApiHelper {
  Dio _dio;
  BaseOptions options;
  String authTOKEN;

  ApiHelper() {
    options = BaseOptions(
      connectTimeout: 50000,
      receiveTimeout: 50000,
    );
     setAuthToken().then((value){
       if(value != null){
         authTOKEN=value;
       }
     });
    _dio = Dio(options);

    options.baseUrl = Strings.BASE_URL;
    _dio.options.headers['content-Type'] = 'application/json';
//    _dio.options.headers["authToken"] = 'uSFnprTQMxQyi5LqM5dg9A==';
    if (authTOKEN != null) {
      _dio.options.headers["authToken"] = "$authTOKEN";
    }

    _dio.interceptors.add(LoggingInterceptor());
//    var token = isIos ? StringResourse.ios_jwt : StringResourse.android_jwt;
  }

  Future<String> setAuthToken() async {
    SessionManager _sessionManager = new SessionManager();
    await _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.accessToken}');
        return userData.accessToken.toString();
      } else
        return null;
    });
  }

  dynamic post(
      {String apiUrl, FormData formData, bool afterLogin = true}) async {
    try {
      if (authTOKEN != null) {
        _dio.options.headers["authToken"] = "$authTOKEN";
      } else {
        setAuthToken().then((value) {
          if(value != null){
            authTOKEN = value;
            _dio.options.headers["authToken"] = "$authTOKEN";
          }
        });
      }

      Response res = await _dio.post(apiUrl, data: formData);
      print("statusCode${res.statusCode}");
      return res.data;
    } on DioError catch (e) {
      _handleError(e);
      throw Exception("Something wrong");
    }
  }

  dynamic postJson(
      {String apiUrl, dynamic formData}) async {
    try {
      _dio.options.headers['accessToken'] = 'uSFnprTQMxQyi5LqM5dg9A==';
      Response res = await _dio.post(apiUrl, data: formData);
      print("statusCode${res.statusCode}");
      print("headers----> ${res.headers}");
      return res.data;
    } on DioError catch (e) {
      _handleError(e);
      throw Exception("Something wrong");
    }
  }

  dynamic get(
      {String apiUrl, FormData formData, bool afterLogin = true}) async {
    print("ApiUrl  $apiUrl");

    try {
      if (authTOKEN != null) {
        _dio.options.headers["authToken"] = "$authTOKEN";
      } else {
        setAuthToken().then((value) {
          if(value != null){
            authTOKEN = value;
            debugPrint('authToken---------------3   $authTOKEN');
            _dio.options.headers["authToken"] = "$authTOKEN";
          }
        });
      }

      Response res = await _dio.get(
        apiUrl,
      );

      print("statusCode${res.statusCode}");
      print("REPPPPP${json.decoder}");
      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");
      print("Errrororororororororororororororo");
      if (e.error != null && e.response.data != null) {
        print(e.response.data);
        //_handleError(e.error);
        //return LoginResponse.fromJson(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }

  dynamic delete({String apiUrl, String authToken}) async {
    try {
      Response res = await _dio.delete(
        apiUrl,
      );

      print("statusCode${res.statusCode}");

      return res.statusCode;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");
      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  dynamic patch({
    String apiUrl,
    FormData formData,
  }) async {
    try {
      Response res = await _dio.patch(apiUrl, data: formData);

      print("statusCode${res.statusCode}");

      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");

      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  String _handleError(DioError error) {
    AppConstantHelper helper = AppConstantHelper();
    String errorDescription = "";

    DioError dioError = error;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        helper.showAlert(true, "Request to API server was cancelled");
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        helper.showAlert(true, "Connection timeout with API server");
        break;
      case DioErrorType.DEFAULT:
        helper.showAlert(
            true, "Connection to API server failed due to internet connection");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        helper.showAlert(true, "Receive timeout in connection with API server");
        break;
      case DioErrorType.RESPONSE:
        var res = CommonResponse.fromJson(dioError.response.data);
        helper.showAlert(true, "${res.message}");
        break;
      case DioErrorType.SEND_TIMEOUT:
        helper.showAlert(true, "Send timeout in connection with API server");
        break;
    }
  }
}
