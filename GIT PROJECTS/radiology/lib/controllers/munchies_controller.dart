
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/munchies_model.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/repo/munchies_repo.dart';


class MunchiesController extends GetxController {
  final MunchiesRepo munchiesRepo;

  MunchiesController({required this.munchiesRepo});

  bool _isMunchiesLoading = false;
  bool get isMunchiesLoading => _isMunchiesLoading;

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;
  void setOffset(int offset) {
    _offset= offset;
  }
  void showBottomLoader () {
    _isMunchiesLoading = true;
    update();
  }




  List<NoteListModel>? _munchiesList;
  List<NoteListModel>? get munchiesList => _munchiesList;
  Future<void> getMunchesList() async {
    _isMunchiesLoading = true;
    update();
    try {
      Response response = await munchiesRepo.getMunchiesList();
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData["status"] == "success") {
          List<dynamic> responseData = response.body['data']['datalist'];
          _munchiesList = responseData.map((json) => NoteListModel.fromJson(json)).toList();
        } else {
          print("Error while fetching Note list: ");
        }
      } else {
        print("Error while fetching Data Error list: ");
      }
    } catch (error) {
      print("Error while fetching Note list: ");
    }
    _isMunchiesLoading = false;
    update();
  }

  bool _isMunchiesNotesLoading = false;
  bool get isMunchiesNotesLoading => _isMunchiesNotesLoading;

  List<CategoryNoteListModel>? _categoryNoteList;
  List<CategoryNoteListModel>? get categoryNoteList => _categoryNoteList;

  Future<void> getMunchesPaginatedList(String page,String categoryId) async {
    _isMunchiesNotesLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _categoryNoteList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await munchiesRepo.getCategoryMunchesList(page,categoryId);

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

          _isMunchiesNotesLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isMunchiesNotesLoading) {
          _isMunchiesNotesLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error Notes  list: $e');
      _isMunchiesNotesLoading = false;
      update();
    }
  }

  void readMunchesNoteStatusApi(String pageNo, categoryID) async {
    Response response = await munchiesRepo.readMunchesNoteStatus(pageNo, categoryID);
    if (response.statusCode == 200) {
    }
    update();
  }


  RxInt currentPageIndex = 0.obs;






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
