import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionActionModel.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/models/profileimage/AddProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/userweight/AddUserWeightApiResponse.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
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
        apiUrl: Strings.BASE_URL + ApiEndPoints.resetYourProgram,
        formData: value);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<NutritionsApiResponse> getAllNutrition(
    String userId,
  ) async {
    var response = await apiHelper.get(
      apiUrl:
          Strings.BASE_URL + ApiEndPoints.getAllNutritions + '?userId=$userId',
    );
    Map<String, dynamic> data = jsonDecode(response);
    return NutritionsApiResponse.fromJson(data);
  }

  Future<LoginResponse> actionFavNutrition(
    NutritionActionModel nutritationModel,
  ) async {
    var json = jsonEncode(nutritationModel.toJson());

    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.nutritionActionModel,
        formData: json);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<GetUserWeightApiResponse> getUserWeight({
    String userId,
  }) async {
    var response = await apiHelper.get(
        apiUrl:
            '${Strings.BASE_URL}${ApiEndPoints.getUserWeight}?userId=$userId');
    Map<String, dynamic> data = jsonDecode(response);
    return GetUserWeightApiResponse.fromJson(data);
  }

  Future<AddUserWeightApiResponse> addUserWeight({
    String userId,
    String weight,
  }) async {
    var json = {
      "userId": userId,
      "weight": weight,
    };
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.addUserWeight, formData: json);
    Map<String, dynamic> data = jsonDecode(response);
    return AddUserWeightApiResponse.fromJson(data);
  }

  Future<GetProfileImagesApiResponse> getUserProfileImages({
    String userId,
  }) async {
    var response = await apiHelper.get(
        apiUrl:
        '${Strings.BASE_URL}${ApiEndPoints.getUserProfileImages}?userId=$userId');
    Map<String, dynamic> data = jsonDecode(response);
    return GetProfileImagesApiResponse.fromJson(data);
  }

  Future<AddProfileImagesApiResponse> addUserProfileImage ({
    String userId,
    String path,
  }) async {
    FormData formData = new FormData.fromMap({
      'userId': userId,
      'file': path == null
          ? ""
          : await MultipartFile.fromFile(path,
          filename: File(path).path.split('/').last),

    });

    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.addUserWeight, formData: formData);
    Map<String, dynamic> data = jsonDecode(response);
    return AddProfileImagesApiResponse.fromJson(data);
  }


}
