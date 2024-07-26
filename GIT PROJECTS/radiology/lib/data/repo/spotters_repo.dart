import 'package:get/get_connect/http/src/response/response.dart';

import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/utils/app_constants.dart';

class SpottersRepo {
  final ApiClient apiClient;
  SpottersRepo({required this.apiClient});

  Future<Response> getSpottersPaginatedList(page) {
    return apiClient.getData('${AppConstants.spottersListUrl}?page=$page');
  }
  Future<Response> getSpottersDetails(id) {
    return apiClient.getData('${AppConstants.spottersDetailsUrl}?id=$id');
  }

  Future<Response> saveSpotter(String? userId,String? spotterId,) async {
    return await apiClient.postData(AppConstants.saveBookMarkUrl, {"user_id": userId, "spotter_id" :spotterId});
  }

  Future<Response> unSaveBookmark(String? id,) async {
    return await apiClient.postData(AppConstants.saveBookMarkUrl, {"id": id, "status" : '0'});
  }

  Future<Response> getSavedBookmarkList(page,userId) async {
    return await apiClient.getData('${AppConstants.bookMarkListUrl}?page=$page&user_id=$userId');
  }

  Future<Response> getSavedNoteList(page,userId) async {
    return await apiClient.getData('${AppConstants.savedNotesListUrl}?page=$page&user_id=$userId');
  }

  Future<Response> saveNote(String? userId,String? noteId,) async {
    return await apiClient.postData(AppConstants.savedNoteUrl, {"user_id": userId, "blog_id" : noteId});
  }

  Future<Response> unSaveNote(String? id,) async {
    return await apiClient.postData(AppConstants.savedNoteUrl, {"id": id, "status" : '0'});
  }

}