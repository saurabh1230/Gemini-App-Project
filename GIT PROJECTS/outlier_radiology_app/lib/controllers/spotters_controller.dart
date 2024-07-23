import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/data/model/response/note_list_model.dart';
import 'package:outlier_radiology_app/data/model/response/spotters_list_model.dart';
import 'package:outlier_radiology_app/data/repo/spotters_repo.dart';

class SpottersController extends GetxController implements GetxService {
  final SpottersRepo spottersRepo;
  SpottersController({required this.spottersRepo});

  final pageController = PageController();

  void goToPage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  bool _isSpottersLoading = false;
  bool get isSpottersLoading => _isSpottersLoading;

  List<SpottersListModel>? _spottersList;
  List<SpottersListModel>? get spottersList => _spottersList;

  Future<void> getSpottersList() async {
    _isSpottersLoading = true;
    update();
    try {
      Response response = await spottersRepo.getSpottersList();
      if (response.statusCode == 200) {
        var responseData = response.body;
        if(responseData["status"]  == "success") {
          List<dynamic> responseData = response.body['data']['datalist'];
          _spottersList = responseData.map((json) => SpottersListModel.fromJson(json)).toList();
          _isSpottersLoading = false;
          update();
        } else {
          print("Error while fetching Note list: ");
          _isSpottersLoading = false;
        }
      } else {
        print("Error while fetching Data Error list: ");
      }
    } catch (error) {
      print("Error while fetching Note list: ");
    }
    _isSpottersLoading = false;
    update();
  }

}
