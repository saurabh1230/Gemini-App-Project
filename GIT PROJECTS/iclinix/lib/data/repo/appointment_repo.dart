import 'dart:async';

import 'package:iclinix/data/api/api_client.dart';
import 'package:iclinix/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppointmentRepo {
  final ApiClient apiClient;
  AppointmentRepo({required this.apiClient,});

  Future<Response> getPlansList() {
    return apiClient.getData(AppConstants.planListUrl,method: 'GET');
  }



}




