import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/network/ApiEndPoints.dart';
import '../Strings.dart';
import 'ApiHelper.dart';

class ApiRepository {
  ApiHelper apiHelper = ApiHelper();

  Future<LoginResponse> login(
    String email,
    String password,
  ) async {
    var value = {'email': email, 'password': password};
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.login, formData: value);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<LoginResponse> forgotPassword(
    String email,
  ) async {
    var value = {'email': email};
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.forgotPassword,
        formData: value);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<LoginResponse> getUserDetails(
    String userId,
  ) async {
    var response = await apiHelper.get(
      apiUrl:
          Strings.BASE_URL + ApiEndPoints.getUserDetails + '?userId=$userId',
    );
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<LoginResponse> resetYourProgram(
      String userId,
      String trainingWeek,
      ) async {
    var value = {'userId': userId, 'trainingWeek': trainingWeek};
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.resetYourProgram, formData: value);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

}

