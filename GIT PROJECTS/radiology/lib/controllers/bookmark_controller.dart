import 'package:get/get.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/spotters_list_model.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/widgets/custom_snackbar_widget.dart';

class BookmarkController extends GetxController implements GetxService {
  final SpottersRepo spottersRepo;

  BookmarkController({required this.spottersRepo});

  List<SpottersListModel?>? _bookmarkList = [];

  List<SpottersListModel?>? get bookmarkList => _bookmarkList;


  List<int?> _bookmarkIdList = [];

  List<int?> get bookmarkIdList => _bookmarkIdList;

  void addToSpotterList(String? userId,SpottersListModel? spottersListModel) async {
    Response response = await spottersRepo.saveSpotter(Get.find<AuthController>().profileData!.id.toString(),
        spottersListModel!.id.toString());
    if (response.statusCode == 200) {
      _bookmarkList!.add(spottersListModel);
      _bookmarkIdList.add(spottersListModel.id);
      showCustomSnackBar('Spotter Saved', isError: false);
    }
    update();
  }

  void removeFromBookMarkList(int? id,) async {
    Response response = await spottersRepo.saveSpotter(Get.find<AuthController>().profileData!.id.toString(),id.toString());
    if (response.statusCode == 200) {
      int idIndex = -1;
      idIndex = _bookmarkIdList.indexOf(id);
      _bookmarkIdList.removeAt(idIndex);
      _bookmarkList!.removeAt(idIndex);
      getSavedSpottersPaginatedList('1');
      showCustomSnackBar('Spotter Unsaved', isError: false);
    }
    update();
  }


  int _offset = 1;

  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;

  int? get pageSize => _pageSize;

  void setOffset(int offset) {
    _offset = offset;
  }

  //
  bool _isSavedSpottersLoading = false;

  bool get isSavedSpottersLoading => _isSavedSpottersLoading;

  List<SpottersListModel>? _savedSpottersList;

  List<SpottersListModel>? get savedSpottersList => _savedSpottersList;

  void showSavedBottomLoader() {
    _isSavedSpottersLoading = true;
    update();
  }

  Future<void> getSavedSpottersPaginatedList(String page) async {
    _isSavedSpottersLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _savedSpottersList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getSavedBookmarkList(page,Get.find<AuthController>().profileData!.id.toString());

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<SpottersListModel> newDataList = dataList.map((json) =>
              SpottersListModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _savedSpottersList = newDataList;
          } else {
            // Append data for subsequent pages
            _savedSpottersList!.addAll(newDataList);
          }

          _isSavedSpottersLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isSavedSpottersLoading) {
          _isSavedSpottersLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching list: $e');
      _isSavedSpottersLoading = false;
      update();
    }
  }

  List<CategoryNoteListModel?>? _bookmarkNoteList = [];
  List<CategoryNoteListModel?>? get bookmarkNoteList => _bookmarkNoteList;

  List<int?> _bookmarkNoteIdList = [];
  List<int?> get bookmarkNoteIdList => _bookmarkNoteIdList;

  void addNoteBookMarkList(String? userId,CategoryNoteListModel? notesListModel) async {
    Response response = await spottersRepo.saveNote(Get.find<AuthController>().profileData!.id.toString(),notesListModel!.id.toString(),);
    if (response.statusCode == 200) {
      _bookmarkNoteList!.add(notesListModel);
      _bookmarkNoteIdList.add(notesListModel.id);
      showCustomSnackBar('Note Saved', isError: false);
    }
    update();
  }

  void removeNoteBookMarkList(int? id,) async {
    Response response = await spottersRepo.saveNote(Get.find<AuthController>().profileData!.id.toString(),id.toString());
    if (response.statusCode == 200) {
      int idIndex = -1;
      idIndex = _bookmarkNoteIdList.indexOf(id);
      _bookmarkNoteIdList.removeAt(idIndex);
      _bookmarkNoteList!.removeAt(idIndex);
      getSavedNotesPaginatedList('1');
      showCustomSnackBar('Note Unsaved', isError: false);
    }
    update();
  }




  bool _isSavedNotesLoading = false;

  bool get isSavedNotesLoading => _isSavedNotesLoading;

  List<CategoryNoteListModel>? _savedNotesList;

  List<CategoryNoteListModel>? get savedNotesList => _savedNotesList;

  void showSavedNotesBottomLoader() {
    _isSavedSpottersLoading = true;
    update();
  }

  Future<void> getSavedNotesPaginatedList(String page) async {
    _isSavedNotesLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _savedNotesList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getSavedNoteList(page,Get.find<AuthController>().profileData!.id.toString());

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<CategoryNoteListModel> newDataList = dataList.map((json) =>
              CategoryNoteListModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _savedNotesList = newDataList;
          } else {
            // Append data for subsequent pages
            _savedNotesList!.addAll(newDataList);
          }

          _isSavedNotesLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isSavedNotesLoading) {
          _isSavedNotesLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching list: $e');
      _isSavedNotesLoading = false;
      update();
    }
  }
}