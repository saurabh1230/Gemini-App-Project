import 'package:get/get_connect/http/src/response/response.dart';

import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/utils/app_constants.dart';

class NoteRepo {
  final ApiClient apiClient;
  NoteRepo({required this.apiClient});
  Future<Response> getNoteList() {
    return apiClient.getData(AppConstants.noteListUrl);
  }

  Future<Response> getCategoryNoteList(page,categoryId) {
    return apiClient.getData('${AppConstants.categoryNoteUrl}?page=$page&category=$categoryId');
  }

  Future<Response> getSpottersList() {
    return apiClient.getData(AppConstants.spottersListUrl);
  }

  Future<Response> readNoteStatus(String? pageNo,String? categoryId,) async {
    return await apiClient.postData(AppConstants.readNoteStatus, {"read_note": pageNo, "category" : categoryId});
  }

  Future<Response> getNoteDetails(id) {
    return apiClient.getData('${AppConstants.noteDetailsUrl}?id=$id');
  }



}