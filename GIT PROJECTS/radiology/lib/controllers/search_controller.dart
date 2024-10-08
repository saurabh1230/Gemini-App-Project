import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/search_model.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/widgets/custom_snackbar_widget.dart';

class SearchDataController extends GetxController implements GetxService {
  final SpottersRepo spottersRepo;

  SearchDataController({required this.spottersRepo});

  bool _isSearchLoading = false;
  bool get isSearchLoading => _isSearchLoading;

  List<SearchModel>? _searchNoteList;
  List<SearchModel>? get searchNoteList => _searchNoteList;

  List<SearchModel>? _searchSpottersList;
  List<SearchModel>? get searchSpottersList => _searchSpottersList;

  List<SearchModel>? _searchOsceList;
  List<SearchModel>? get searchOsceList => _searchOsceList;

  List<SearchModel>? _searchMunchiesList;
  List<SearchModel>? get searchMunchiesList => _searchMunchiesList;

  List<SearchModel>? _searchlearnList;
  List<SearchModel>? get searchlearnList => _searchlearnList;

  List<SearchModel>? _searchBasicsList;
  List<SearchModel>? get searchBasicsList => _searchBasicsList;

  Future<void> getSearchList(String title) async {
    _isSearchLoading = true;
    update();

    try {
      Response response = await spottersRepo.getSearchApi(title);
      if (response.statusCode == 200) {
        var responseData = response.body;
        print(responseData); // Log the entire response

        if (responseData["status"] == "success") {
          // Reset lists
          _searchNoteList = [];
          _searchSpottersList = [];
          _searchOsceList = [];
          _searchMunchiesList = [];
          _searchlearnList = [];
          _searchBasicsList = [];

          // Safely access lists and check for null
          List<dynamic> notesList = responseData['data']['datalist']['notes'] ?? [];
          List<dynamic> spottersList = responseData['data']['datalist']['spotters'] ?? [];
          List<dynamic> osceList = responseData['data']['datalist']['osce'] ?? [];
          List<dynamic> munchiesList = responseData['data']['datalist']['munchies'] ?? [];
          List<dynamic> learnList = responseData['data']['datalist']['whatchandlearn'] ?? [];
          List<dynamic> basicsList = responseData['data']['datalist']['basics'] ?? [];

          // Map the response to model classes, adding null checks
          _searchNoteList = notesList.map((json) => SearchModel.fromJson(json)).toList();
          _searchSpottersList = spottersList.where((item) => item != null).map((json) => SearchModel.fromJson(json)).toList();
          _searchOsceList = osceList.where((item) => item != null).map((json) => SearchModel.fromJson(json)).toList();
          _searchMunchiesList = munchiesList.where((item) => item != null).map((json) => SearchModel.fromJson(json)).toList();
          _searchlearnList = learnList.where((item) => item != null).map((json) => SearchModel.fromJson(json)).toList();
          _searchBasicsList = basicsList.where((item) => item != null).map((json) => SearchModel.fromJson(json)).toList();

          // Log lengths for debugging
          print("Mapped note list length: ${_searchNoteList!.length}");
          print("Mapped spotters list length: ${_searchSpottersList!.length}");
          print("Mapped osce list length: ${_searchOsceList!.length}");
          print("Mapped munchies list length: ${_searchMunchiesList!.length}");
          print("Mapped learn list length: ${_searchlearnList!.length}");
          print("Mapped basics list length: ${_searchBasicsList!.length}");

        } else {
          Get.snackbar("Error", "Failed to fetch search results.", snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data. Status code: ${response.statusCode}", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred: $error", snackPosition: SnackPosition.BOTTOM);
    } finally {
      // Always update the loading state
      _isSearchLoading = false;
      update();
    }
  }


}
