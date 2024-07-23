import 'package:get/get_connect/http/src/response/response.dart';

import 'package:outlier_radiology_app/data/api/api_client.dart';
import 'package:outlier_radiology_app/utils/app_constants.dart';

class SpottersRepo {
  final ApiClient apiClient;
  SpottersRepo({required this.apiClient});


  Future<Response> getSpottersList() {
    return apiClient.getData(AppConstants.spottersListUrl);
  }

}