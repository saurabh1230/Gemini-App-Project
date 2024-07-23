import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/data/model/response/category_note_list_model.dart';
import 'package:outlier_radiology_app/data/model/response/note_list_model.dart';
import 'package:outlier_radiology_app/data/repo/note_repo.dart';
import 'package:outlier_radiology_app/features/widgets/custom_snackbar_widget.dart';

class NotesController extends GetxController implements GetxService {
 final NoteRepo noteRepo;
 NotesController({required this.noteRepo});

  bool _isNoteLoading = false;
  bool get isNoteLoading => _isNoteLoading;

  List<NoteListModel>? _noteList;
  List<NoteListModel>? get noteList => _noteList;

  Future<void> getNoteList() async {
   _isNoteLoading = true;
   update();
   try {
    Response response = await noteRepo.getNoteList();
    if (response.statusCode == 200) {
     var responseData = response.body;
     if(responseData["status"]  == "success") {
      List<dynamic> responseData = response.body['data']['datalist'];
      _noteList = responseData.map((json) => NoteListModel.fromJson(json)).toList();
      _isNoteLoading = false;
      update();
     } else {
      print("Error while fetching Note list: ");
      _isNoteLoading = false;
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

 List<CategoryNoteListModel>? _categoryNoteList;
 List<CategoryNoteListModel>? get categoryNoteList => _categoryNoteList;

 Future<void> getCategoryNoteList(categoryId) async {
  _isCategoryNoteLoading = true;
  update();
  try {
   Response response = await noteRepo.getCategoryNoteList(categoryId);
   if (response.statusCode == 200) {
    var responseData = response.body;
    if(responseData["status"]  == "success") {
     List<dynamic> responseData = response.body['data']['notes'];
     _categoryNoteList = responseData.map((json) => CategoryNoteListModel.fromJson(json)).toList();
     _isCategoryNoteLoading = false;
     update();
    } else {
     print("Error while fetching Note list: ");
     _isCategoryNoteLoading = false;
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







 List<String> notesCategory = ['PHYSICS','CNS','CVS','CHEST','GUT','GIT','HEPATOBILIARY','HEAD AND NECK','MSK','BREAST','RECENT ADVANCES'];
 List<Color> randomColors = [
  Colors.redAccent,       // Bright red color
  Colors.blueAccent,      // Bright blue color
  Colors.greenAccent,     // Bright green color
  Colors.orangeAccent,    // Bright orange color
  Colors.purpleAccent,    // Bright purple color
  Colors.tealAccent,      // Bright teal color
   Colors.orangeAccent,    // Bright yellow color
  Colors.pinkAccent,      // Bright pink color
  Colors.cyanAccent,      // Bright cyan color
  Colors.indigoAccent,    // Bright indigo color
   Colors.orangeAccent,     // Bright lime color
  ];

  var currentIndex = 0;
  PageController pageController = PageController();

  void nextPage() {
   if (currentIndex < 4) {
    currentIndex++;
    pageController.animateToPage(
     currentIndex,
     duration: const Duration(milliseconds: 300),
     curve: Curves.easeIn,
    );
   }
   update();
  }

  void previousPage() {
   if (currentIndex > 0) {
    currentIndex--;
    pageController.animateToPage(
     currentIndex,
     duration: const Duration(milliseconds: 300),
     curve: Curves.easeIn,
    );
   }
   update();
  }

  void updateIndex(int index) {
   currentIndex = index;
   update();
  }

}