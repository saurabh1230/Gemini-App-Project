
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/repo/note_repo.dart';

class NotesController extends GetxController {
 final NoteRepo noteRepo;

 NotesController({required this.noteRepo});

 bool _isNoteLoading = false;
 bool get isNoteLoading => _isNoteLoading;

 List<NoteListModel>? _noteList;
 List<NoteListModel>? get noteList => _noteList;

 RxInt currentPageIndex = 0.obs;

 Future<void> getNoteList() async {
  _isNoteLoading = true;
  update();
  try {
   Response response = await noteRepo.getNoteList();
   if (response.statusCode == 200) {
    var responseData = response.body;
    if (responseData["status"] == "success") {
     List<dynamic> responseData = response.body['data']['datalist'];
     _noteList = responseData.map((json) => NoteListModel.fromJson(json)).toList();
    } else {
     print("Error while fetching Note list: ");
    }
   } else {
    print("Error while fetching Data Error list: ");
   }
  } catch (error) {
   print("Error while fetching Note list: ");
  }
  _isNoteLoading = false;
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


 Future<void> getNotesPaginatedList(String page,String categoryId) async {
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

    Response response = await noteRepo.getCategoryNoteList(page,categoryId);

    if (response.statusCode == 200) {
     // Adjust the parsing to match the response structure
     Map<String, dynamic> responseData = response.body['data']['notes'];
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

 void readNoteStatusApi(String pageNo, categoryID) async {
  Response response = await noteRepo.readNoteStatus(pageNo, categoryID);
  if (response.statusCode == 200) {
  }
  update();
 }

 bool _isSpottersDetailsLoading = false;
 bool get isSpottersDetailsLoading => _isSpottersDetailsLoading;

 // NotesDetails? _spottersDetails;
 // SpottersDetailsModel? get spottersDetails => _spottersDetails;
 //
 // Future<SpottersDetailsModel?> getSpottersDetailsApi(String? id) async {
 //  _isSpottersDetailsLoading = true;
 //  _spottersDetails = null;
 //  update();
 //
 //  try {
 //   Response response = await spottersRepo.getSpottersDetails(id);
 //
 //   if (response.statusCode == 200) {
 //    final data = response.body['data'];
 //
 //    if (data != null && data['datalist'] != null) {
 //     Map<String, dynamic> responseData = data['datalist'];
 //     _spottersDetails = SpottersDetailsModel.fromJson(responseData);
 //    } else {
 //     // Handle case where datalist is null
 //     print("datalist is null");
 //    }
 //   } else {
 //    // Handle non-200 status codes
 //    print("Failed to load data: ${response.statusCode}");
 //    // ApiChecker.checkApi(response);
 //   }
 //  } catch (e) {
 //   // Handle exceptions
 //   print("Exception occurred: $e");
 //  }
 //
 //  _isSpottersDetailsLoading = false;
 //  update();
 //  return _spottersDetails;
 // }

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


 bool _isNoteDetailsLoading = false;
 bool get isNoteDetailsLoading => _isNoteDetailsLoading;

 CategoryNoteListModel? _noteDetails;

 CategoryNoteListModel? get noteDetails => _noteDetails;

 Future<CategoryNoteListModel?> getNoteDetailsApi(String? id) async {
  print('munchies details APi ================>');
  _isNoteDetailsLoading = true;
  _noteDetails = null;
  update();

  try {
   Response response = await noteRepo.getNoteDetails(id);

   if (response.statusCode == 200) {
    final data = response.body['data'];

    if (data != null && data['datalist'] != null) {
     Map<String, dynamic> responseData = data['datalist'];
     _noteDetails = CategoryNoteListModel.fromJson(responseData);
    } else {
     // Handle case where datalist is null
     print("basicshow is null");
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

  _isNoteDetailsLoading = false;
  update();
  return _noteDetails;
 }
}
