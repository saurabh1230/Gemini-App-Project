import 'dart:async';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:outlier_radiology_app/data/api/api_client.dart';
import 'package:outlier_radiology_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<bool> saveUserToken(String token, /*String zoneTopic*/) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.token, token);
  }


  Future<Response> login(String? username,String? password,) async {
    return await apiClient.postData(AppConstants.login, {"username": username, "password" : password});
  }

  Future<Response> registerRepo(String? firstname,String? email,String? password,String? confirmPassword) async {
    return await apiClient.postData(AppConstants.register, {
      "firstname" :firstname,
      "email" :email,
      "password": password,
      "password_confirmation" :confirmPassword,
    });
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<Response> logOutApi() async {
    return await apiClient.postData(AppConstants.logOut,{});
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.token);
    await sharedPreferences.remove(AppConstants.userAddress);
    return true;
  }

}
