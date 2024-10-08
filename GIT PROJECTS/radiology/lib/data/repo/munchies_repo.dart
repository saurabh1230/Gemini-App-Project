import 'package:get/get_connect/http/src/response/response.dart';

import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/utils/app_constants.dart';

class MunchiesRepo {
  final ApiClient apiClient;
  MunchiesRepo({required this.apiClient});
  Future<Response> getMunchiesList() {
    return apiClient.getData(AppConstants.munchiesListUrl);
  }
  Future<Response> getCategoryMunchesList(page,categoryId) {
    return apiClient.getData('${AppConstants.categoryMunchesUrl}?page=$page&category=$categoryId');
  }

  Future<Response> readMunchesNoteStatus(String? pageNo,String? categoryId,) async {
    return await apiClient.postData(AppConstants.readMunchesNoteStatus, {"read_munchie": pageNo, "category" : categoryId});
  }

  Future<Response> saveMunchies(String? userId,String? noteId,) async {
    return await apiClient.postData(AppConstants.savedMunchiesUrl, {"user_id": userId, "munchie_id" : noteId});
  }

  Future<Response> getMunchiesDetails(id) {
    return apiClient.getData('${AppConstants.munchieDetailsUrl}?id=$id');
  }




}