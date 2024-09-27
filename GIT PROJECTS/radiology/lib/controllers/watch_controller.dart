
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/model/response/watchLearnModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:radiology/data/repo/watch_repo.dart';

class WatchController extends GetxController {
  final WatchRepo watchRepo;

  WatchController({required this.watchRepo});

  bool _isWatchLoading = false;
  bool get isWatchLoading => _isWatchLoading;

  List<NoteListModel>? _noteList;
  List<NoteListModel>? get noteList => _noteList;

  RxInt currentPageIndex = 0.obs;

  Future<void> getWatchList() async {
    _isWatchLoading = true;
    update();
    try {
      Response response = await watchRepo.getWatchCategoryList();
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData["status"] == "success") {
          List<dynamic> responseData = response.body['data']['datalist'];
          _noteList = responseData.map((json) => NoteListModel.fromJson(json)).toList();
        } else {
          print("Error while fetching Watch list: ");
        }
      } else {
        print("Error while fetching Data Error list: ");
      }
    } catch (error) {
      print("Error while fetching Watch list: ");
    }
    _isWatchLoading = false;
    update();
  }

  bool _isCategoryNoteLoading = false;
  bool get isCategoryNoteLoading => _isCategoryNoteLoading;

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;

  void setOffset(int offset) {
    _offset= offset;
  }
  void showBottomLoader () {
    _isCategoryNoteLoading = true;
    update();
  }
  List<WatchLearnModel>? _categoryNoteList;
  List<WatchLearnModel>? get categoryNoteList => _categoryNoteList;


  Future<void> getWatchPaginatedList(String page,String categoryId) async {
    _isCategoryNoteLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _categoryNoteList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await watchRepo.getWatchNoteList(page,categoryId);

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = response.body['data']['watchs'];
          List<dynamic> dataList = responseData['data'];
          List<WatchLearnModel> newDataList = dataList.map((json) => WatchLearnModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _categoryNoteList = newDataList;
          } else {
            // Append data for subsequent pages
            _categoryNoteList!.addAll(newDataList);
          }

          _isCategoryNoteLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isCategoryNoteLoading) {
          _isCategoryNoteLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error Notes  list: $e');
      _isCategoryNoteLoading = false;
      update();
    }
  }

  void readWatchStatusApi(String pageNo, categoryID) async {
    Response response = await watchRepo.readWatchStatus(pageNo, categoryID);
    if (response.statusCode == 200) {
    }
    update();
  }





  var currentIndex = 0;
  PageController pageController = PageController();

  void nextPage() {
    if (currentIndex < (_categoryNoteList?.length ?? 0) - 1) {
      currentIndex++;
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
    update();
  }

  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }

  Map<int, bool> expandedItems = {};

  void toggleExpanded(int id) {
    expandedItems[id] = !(expandedItems[id] ?? false);
    update();
  }


}
