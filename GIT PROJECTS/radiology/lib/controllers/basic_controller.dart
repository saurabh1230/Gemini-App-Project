
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/munchies_model.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/data/repo/basic_repo.dart';
import 'package:radiology/data/repo/munchies_repo.dart';


class BasicController extends GetxController {
  final BasicRepo basicRepo;

  BasicController({required this.basicRepo});

  bool _isBasicLoading = false;
  bool get isBasicLoading => _isBasicLoading;

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;
  void setOffset(int offset) {
    _offset= offset;
  }
  void showBottomLoader () {
    _isBasicLoading = true;
    update();
  }




  List<NoteListModel>? _list;
  List<NoteListModel>? get list => _list;
  Future<void> getBasicList() async {
    _isBasicLoading = true;
    update();
    try {
      Response response = await basicRepo.getBasicCategoryList();
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData["status"] == "success") {
          List<dynamic> responseData = response.body['data']['datalist'];
          _list = responseData.map((json) => NoteListModel.fromJson(json)).toList();
        } else {
          print("Error while fetching Note list: ");
        }
      } else {
        print("Error while fetching Data Error list: ");
      }
    } catch (error) {
      print("Error while fetching Note list: ");
    }
    _isBasicLoading = false;
    update();
  }

  bool _isNotesLoading = false;
  bool get isNotesLoading => _isNotesLoading;

  List<CategoryNoteListModel>? _categoryNoteList;
  List<CategoryNoteListModel>? get categoryNoteList => _categoryNoteList;

  Future<void> getBasicPaginatedList(String page,String categoryId) async {
    _isNotesLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _categoryNoteList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await basicRepo.getBasicNotesList(page,categoryId);

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = response.body['data']['notes'];
          List<dynamic> dataList = responseData['data'];
          List<CategoryNoteListModel> newDataList = dataList.map((json) => CategoryNoteListModel.fromJson(json)).toList();

          if (page == '1') {
            _categoryNoteList = newDataList;
          } else {
            _categoryNoteList!.addAll(newDataList);
          }

          _isNotesLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isNotesLoading) {
          _isNotesLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error Basic list: $e');
      _isNotesLoading = false;
      update();
    }
  }

  void readBasicNoteStatusApi(String pageNo, categoryID) async {
    Response response = await basicRepo.readBasicNoteStatus(pageNo, categoryID);
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
