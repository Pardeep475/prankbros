import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/motivation/MotivationActivityApiResponse.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionActionModel.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/models/profileimage/AddProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/PictureFinalModel.dart';
import 'package:prankbros2/models/updateprofile/UpdateProfileApiResponse.dart';
import 'package:prankbros2/models/userweight/AddUserWeightApiResponse.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
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
      {String userId, String accessToken}) async {
    var response = await apiHelper.get(
      apiUrl:
          Strings.BASE_URL + ApiEndPoints.getUserDetails + '?userId=$userId',
      accessToken: accessToken,
    );
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<LoginResponse> resetYourProgram(
      {String userId, String trainingWeek, String accessToken}) async {
    var value = {'userId': userId, 'trainingWeek': trainingWeek};
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.resetYourProgram,
        formData: value,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<NutritionsApiResponse> getAllNutrition(
      {String userId, String accessToken}) async {
    var response = await apiHelper.get(
      apiUrl:
          Strings.BASE_URL + ApiEndPoints.getAllNutritions + '?userId=$userId',
      accessToken: accessToken,
    );
    Map<String, dynamic> data = jsonDecode(response);
    return NutritionsApiResponse.fromJson(data);
  }

  Future<LoginResponse> actionFavNutrition(
      {NutritionActionModel nutritationModel, String accessToken}) async {
    var json = jsonEncode(nutritationModel.toJson());

    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.nutritionActionModel,
        formData: json,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<GetUserWeightApiResponse> getUserWeight(
      {String userId, String accessToken}) async {
    var response = await apiHelper.get(
        apiUrl:
            '${Strings.BASE_URL}${ApiEndPoints.getUserWeight}?userId=$userId',
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return GetUserWeightApiResponse.fromJson(data);
  }

  Future<MotivationApiResponse> getMotivation({
    String userId,
    String accessToken,
  }) async {
    var response = await apiHelper.get(
        apiUrl:
            '${Strings.BASE_URL}${ApiEndPoints.getMotivation}?userId=$userId',
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return MotivationApiResponse.fromJson(data);
  }

  Future<MotivationActivityApiResponse> getMotivationActivation(
      {String userId, String trainingWeek, String accessToken}) async {
//    {
//      "userId":1,
//    "trainingWeek":1
//    }

    var value = {"userId": userId, "trainingWeek": trainingWeek};

    var response = await apiHelper.postJson(
        apiUrl: '${Strings.BASE_URL}${ApiEndPoints.getMotivationActivation}',
        formData: value,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return MotivationActivityApiResponse.fromJson(data);
  }

  Future<AddUserWeightApiResponse> addUserWeight(
      {String userId,
      String weight,
      String createdOn,
      String accessToken}) async {
    var json = {
      "userId": userId,
      "weight": weight,
      "createdOn": createdOn,
    };
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.addUserWeight,
        formData: json,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return AddUserWeightApiResponse.fromJson(data);
  }

  Future<List<PictureFinalModel>> getUserProfileImages(
      {String userId, String accessToken}) async {
    var response = await apiHelper.get(
        apiUrl:
            '${Strings.BASE_URL}${ApiEndPoints.getUserProfileImages}?userId=$userId',
        accessToken: accessToken);
    Map<String, dynamic> parsed = jsonDecode(response);

//   final parsed =  data['userProfileImages'];

//    final parsed = json.decode(response.body);
//
    List<PictureFinalModel> _list = new List();
    Queue numQ = new Queue();
    numQ.addAll(parsed["userProfileImages"]);
    Iterator iterator = numQ.iterator;
    while (iterator.moveNext()) {
      Map<String, dynamic> parsed2 = iterator.current;
      List<UserProfileImages> _userProfileImagesList = new List();
      String title = '';

      for (int i = 0; i < parsed2.values.toList().length; i++) {
        debugPrint("parsedvalueis   6-----${parsed2.values.toList()[i]}");
        List<dynamic> map = parsed2.values.toList()[i];
        for (int j = 0; j < map.length; j++) {
          debugPrint("parsedvalueis   7   $j-----${map[j]}");
          debugPrint(
              "parsedvalueis   8   $j -----${UserProfileImages.fromJson(map[j]).createdOn}");
          if (j == 0) {
            title = UserProfileImages.fromJson(map[j]).createdOn;
          }
          _userProfileImagesList.add(UserProfileImages.fromJson(map[j]));
          debugPrint(
              "parsedvalueis   9----   ${_userProfileImagesList.length}");
        }
      }
      _list.add(PictureFinalModel(title: title, list: _userProfileImagesList));
    }
    debugPrint("parsedvalueis   4----   ${_list.length}");
    return _list;
  }

  Future<GetUserWeightApiResponse> deleteUserImage(
      {String userId, String id, String accessToken}) async {
    var response = await apiHelper.get(
        apiUrl:
            '${Strings.BASE_URL}${ApiEndPoints.deleteUserImage}?userId=$userId&id=$id',
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return GetUserWeightApiResponse.fromJson(data);
  }

  Future<AddProfileImagesApiResponse> addUserProfileImage(
      {String userId, String path, String accessToken}) async {
    FormData formData = new FormData.fromMap({
      'userId': userId,
      'file': path == null
          ? ""
          : await MultipartFile.fromFile(path,
              filename: File(path).path.split('/').last),
    });

    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.addUserProfileImages,
        formData: formData,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return AddProfileImagesApiResponse.fromJson(data);
  }

  Future<LoginResponse> changeLanguage(
      {String userId, String language, String accessToken}) async {
    var value = {'userId': userId, 'language': language};
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.changeLanguage,
        formData: value,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return LoginResponse.fromJson(data);
  }

  Future<UpdateProfileApiResponse> updateUserProfile(
      {String userId,
      String firstName,
      String lastName,
      String email,
      String accessToken}) async {
    var value = {
      'id': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.updateProfile,
        formData: value,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return UpdateProfileApiResponse.fromJson(data);
  }

  Future<GetUserTrainingResponseApi> getUserTraining(
      {String screenType,
      String trainingWeek,
      String influencerId,
      String accessToken}) async {
    var value = {
      "influencerId": influencerId,
      "trainingWeek": trainingWeek,
      "trainingType": screenType
    };
    var response = await apiHelper.postJson(
        apiUrl: Strings.BASE_URL + ApiEndPoints.getUserTraining,
        formData: value,
        accessToken: accessToken);
    Map<String, dynamic> data = jsonDecode(response);
    return GetUserTrainingResponseApi.fromJson(data);
  }
}
