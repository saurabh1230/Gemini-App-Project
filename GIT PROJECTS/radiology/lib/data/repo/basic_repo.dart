import 'package:get/get_connect/http/src/response/response.dart';

import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/utils/app_constants.dart';

class BasicRepo {
  final ApiClient apiClient;
  BasicRepo({required this.apiClient});
  Future<Response> getBasicCategoryList() {
    return apiClient.getData(AppConstants.categoryBasicUrl);
  }

  Future<Response> getBasicNotesList(page,categoryId) {
    return apiClient.getData('${AppConstants.basicListUrl}?page=$page&category=$categoryId');
  }

  Future<Response> readBasicNoteStatus(String? pageNo,String? categoryId,) async {
    return await apiClient.postData(AppConstants.readBasicStatus, {"read_basic": pageNo, "category" : categoryId});
  }

  Future<Response> saveBasic(String? userId,String? noteId,) async {
    return await apiClient.postData(AppConstants.savedBasicUrl, {"user_id": userId, "basic_id" : noteId});
  }




}