import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/model/response/osce_model.dart';
import 'package:radiology/data/model/response/spotters_details_model.dart';
import 'package:radiology/data/model/response/spotters_list_model.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/widgets/custom_snackbar_widget.dart';

class SpottersController extends GetxController implements GetxService {
  final SpottersRepo spottersRepo;
  SpottersController({required this.spottersRepo});
  RxInt currentPageIndex = 0.obs;
  final pageController = PageController();

  void goToPage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }


  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;

  void setOffset(int offset) {
    _offset= offset;
  }

  bool _isSpottersLoading = false;
  bool get isSpottersLoading => _isSpottersLoading;

  List<SpottersListModel>? _spottersList;
  List<SpottersListModel>? get spottersList => _spottersList;

  // Future<void> getSpottersList() async {
  //   _isSpottersLoading = true;
  //   update();
  //   try {
  //     Response response = await spottersRepo.getSpottersList();
  //     if (response.statusCode == 200) {
  //       var responseData = response.body;
  //       if(responseData["status"]  == "success") {
  //         List<dynamic> responseData = response.body['data']['datalist'];
  //         _spottersList = responseData.map((json) => SpottersListModel.fromJson(json)).toList();
  //         _isSpottersLoading = false;
  //         update();
  //       } else {
  //         print("Error while fetching Note list: ");
  //         _isSpottersLoading = false;
  //       }
  //     } else {
  //       print("Error while fetching Data Error list: ");
  //     }
  //   } catch (error) {
  //     print("Error while fetching Note list: ");
  //   }
  //   _isSpottersLoading = false;
  //   update();
  // }

  bool _isSpotterPageLoading = false;
  bool get isSpotterPageLoading => _isSpotterPageLoading;

  void showBottomLoader () {
    _isSpottersLoading = true;
    update();
  }
  Future<void> getSpottersPaginatedList(String page) async {
    _isSpottersLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _spottersList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getSpottersPaginatedList(page);

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['datalist'];
          List<dynamic> dataList = responseData['data'];
          List<SpottersListModel> newDataList = dataList.map((json) => SpottersListModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _spottersList = newDataList;
          } else {
            // Append data for subsequent pages
            _spottersList!.addAll(newDataList);
          }

          _isSpottersLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isSpottersLoading) {
          _isSpottersLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching  list: $e');
      _isSpottersLoading = false;
      update();
    }
  }


  bool _isSpottersDetailsLoading = false;
  bool get isSpottersDetailsLoading => _isSpottersDetailsLoading;

  SpottersDetailsModel? _spottersDetails;
  SpottersDetailsModel? get spottersDetails => _spottersDetails;

  Future<SpottersDetailsModel?> getSpottersDetailsApi(String? id) async {
    _isSpottersDetailsLoading = true;
    _spottersDetails = null;
    update();

    try {
      Response response = await spottersRepo.getSpottersDetails(id);

      if (response.statusCode == 200) {
        final data = response.body['data'];

        if (data != null && data['datalist'] != null) {
          Map<String, dynamic> responseData = data['datalist'];
          _spottersDetails = SpottersDetailsModel.fromJson(responseData);
        } else {
          // Handle case where datalist is null
          print("datalist is null");
        }
      } else {
        // Handle non-200 status codes
        print("Failed to load data: ${response.statusCode}");
        // ApiChecker.checkApi(response);
      }
    } catch (e) {
      // Handle exceptions
      print("Exception occurred: $e");
    }

    _isSpottersDetailsLoading = false;
    update();
    return _spottersDetails;
  }
  bool _isOsceLoading = false;
  bool get isOsceLoading => _isOsceLoading;

  List<OsceModel>? _osceList;
  List<OsceModel>? get osceList => _osceList;

  Future<void> getOscePaginatedList(String page) async {
    _isOsceLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _osceList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getOscePaginatedList(page);

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['datalist'];
          List<dynamic> dataList = responseData['data'];
          List<OsceModel> newDataList = dataList.map((json) => OsceModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _osceList = newDataList;
          } else {
            // Append data for subsequent pages
            _osceList!.addAll(newDataList);
          }

          _isOsceLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isOsceLoading) {
          _isOsceLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching osce  list: $e');
      _isOsceLoading = false;
      update();
    }
  }



}
