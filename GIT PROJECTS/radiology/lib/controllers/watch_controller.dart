// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';
// import 'package:radiology/data/model/response/category_note_list_model.dart';
// import 'package:radiology/data/model/response/note_list_model.dart';
// import 'package:radiology/data/repo/note_repo.dart';
// import 'package:radiology/features/widgets/custom_snackbar_widget.dart';
//
// class NotesController extends GetxController implements GetxService {
//  final NoteRepo noteRepo;
//  NotesController({required this.noteRepo});
//
//   bool _isNoteLoading = false;
//   bool get isNoteLoading => _isNoteLoading;
//
//   List<NoteListModel>? _noteList;
//   List<NoteListModel>? get noteList => _noteList;
//
//   Future<void> getNoteList() async {
//    _isNoteLoading = true;
//    update();
//    try {
//     Response response = await noteRepo.getNoteList();
//     if (response.statusCode == 200) {
//      var responseData = response.body;
//      if(responseData["status"]  == "success") {
//       List<dynamic> responseData = response.body['data']['datalist'];
//       _noteList = responseData.map((json) => NoteListModel.fromJson(json)).toList();
//       _isNoteLoading = false;
//       update();
//      } else {
//       print("Error while fetching Note list: ");
//       _isNoteLoading = false;
//      }
//     } else {
//      print("Error while fetching Data Error list: ");
//     }
//    } catch (error) {
//     print("Error while fetching Note list: ");
//    }
//    _isNoteLoading = false;
//    update();
//   }
//
//  bool _isCategoryNoteLoading = false;
//  bool get isCategoryNoteLoading => _isCategoryNoteLoading;
//
//  List<CategoryNoteListModel>? _categoryNoteList;
//  List<CategoryNoteListModel>? get categoryNoteList => _categoryNoteList;
//
//  Future<void> getCategoryNoteList(categoryId) async {
//   _isCategoryNoteLoading = true;
//   _categoryNoteList = [];
//   _categoryNoteList = null;
//   update();
//   try {
//    Response response = await noteRepo.getCategoryNoteList(categoryId);
//    if (response.statusCode == 200) {
//     var responseData = response.body;
//     if(responseData["status"]  == "success") {
//      List<dynamic> responseData = response.body['data']['notes'];
//      _categoryNoteList = responseData.map((json) => CategoryNoteListModel.fromJson(json)).toList();
//      _isCategoryNoteLoading = false;
//      update();
//     } else {
//      print("Error while fetching Note list: ");
//      _isCategoryNoteLoading = false;
//     }
//    } else {
//     print("Error while fetching Data Error list: ");
//    }
//   } catch (error) {
//    print("Error while fetching Note list: ");
//   }
//   _isNoteLoading = false;
//   update();
//  }
//
//
//
//
//
//
//
//  List<String> notesCategory = ['PHYSICS','CNS','CVS','CHEST','GUT','GIT','HEPATOBILIARY','HEAD AND NECK','MSK','BREAST','RECENT ADVANCES'];
//  List<Color> randomColors = [
//   Colors.redAccent,       // Bright red color
//   Colors.blueAccent,      // Bright blue color
//   Colors.greenAccent,     // Bright green color
//   Colors.orangeAccent,    // Bright orange color
//   Colors.purpleAccent,    // Bright purple color
//   Colors.tealAccent,      // Bright teal color
//    Colors.orangeAccent,    // Bright yellow color
//   Colors.pinkAccent,      // Bright pink color
//   Colors.cyanAccent,      // Bright cyan color
//   Colors.indigoAccent,    // Bright indigo color
//    Colors.orangeAccent,     // Bright lime color
//   ];
//
//   var currentIndex = 0;
//   PageController pageController = PageController();
//
//   void nextPage() {
//    if (currentIndex < 4) {
//     currentIndex++;
//     pageController.animateToPage(
//      currentIndex,
//      duration: const Duration(milliseconds: 300),
//      curve: Curves.easeIn,
//     );
//    }
//    update();
//   }
//
//   void previousPage() {
//    if (currentIndex > 0) {
//     currentIndex--;
//     pageController.animateToPage(
//      currentIndex,
//      duration: const Duration(milliseconds: 300),
//      curve: Curves.easeIn,
//     );
//    }
//    update();
//   }
//
//   void updateIndex(int index) {
//    currentIndex = index;
//    update();
//   }
//
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/repo/note_repo.dart';
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
  List<CategoryNoteListModel>? _categoryNoteList;
  List<CategoryNoteListModel>? get categoryNoteList => _categoryNoteList;


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
          List<CategoryNoteListModel> newDataList = dataList.map((json) => CategoryNoteListModel.fromJson(json)).toList();

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
