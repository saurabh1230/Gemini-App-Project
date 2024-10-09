import 'package:get/get_connect/http/src/response/response.dart';

import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/utils/app_constants.dart';

class WatchRepo {
  final ApiClient apiClient;
  WatchRepo({required this.apiClient});
  Future<Response> getWatchCategoryList() {
    return apiClient.getData(AppConstants.categoryWatchLearnUrl);
  }

  Future<Response> getWatchNoteList(page,categoryId) {
    return apiClient.getData('${AppConstants.watchNotesUrl}?page=$page&category=$categoryId');
  }

  Future<Response> getSpottersList() {
    return apiClient.getData(AppConstants.spottersListUrl);
  }

  Future<Response> readWatchStatus(String? pageNo,String? categoryId,) async {
    return await apiClient.postData(AppConstants.readWatchStatus, {"read_watch": pageNo, "category" : categoryId});
  }
  Future<Response> saveWatch(String? userId,String? noteId,) async {
    return await apiClient.postData(AppConstants.savedWatch, {"user_id": userId, "watch_id" : noteId});
  }

  Future<Response> getWatchAndLearnDetails(id) {
    return apiClient.getData('${AppConstants.watchAndLearnDetailsUrl}?id=$id');
  }



}