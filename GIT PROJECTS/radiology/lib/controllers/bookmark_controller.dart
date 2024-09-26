import 'package:get/get.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/data/model/response/category_note_list_model.dart';
import 'package:radiology/data/model/response/osce_model.dart';
import 'package:radiology/data/model/response/spotters_list_model.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/widgets/custom_snackbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookmarkController extends GetxController implements GetxService {
  final SpottersRepo spottersRepo;

  BookmarkController({required this.spottersRepo});

  List<SpottersListModel?>? _bookmarkList = [];

  List<SpottersListModel?>? get bookmarkList => _bookmarkList;


  List<int?> _bookmarkIdList = [];

  List<int?> get bookmarkIdList => _bookmarkIdList;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarks();
    _loadNoteBookmarks();
    _loadOsceBookmarks();
    _loadBasicBookmarks();
    _loadWatchBookmarks();
    _loadMunchieBookmarks();
  }

  Future<void> _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert List<int?> to List<String> for saving
    List<String> bookmarkIds = _bookmarkIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_property_ids', bookmarkIds);
  }

  Future<void> _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_property_ids');
    if (savedIds != null) {
      // Convert List<String> back to List<int?>
      _bookmarkIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }
  void addToSpotterList(String? userId,SpottersListModel? spottersListModel) async {
    Response response = await spottersRepo.saveSpotter(Get.find<AuthController>().profileData!.id.toString(),
        spottersListModel!.id.toString());
    if (response.statusCode == 200) {
      _bookmarkList!.add(spottersListModel);
      _bookmarkIdList.add(spottersListModel.id);
      showCustomSnackBar('Spotter Saved', isError: false);
      await _saveBookmarks();
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
      await _saveBookmarks();
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


  Future<void> _saveNoteBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkIds = _bookmarkNoteIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_note_ids', bookmarkIds);
  }

  Future<void> _loadNoteBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_note_ids');
    if (savedIds != null) {
      _bookmarkNoteIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }

  void addNoteBookMarkList(String? userId,CategoryNoteListModel? notesListModel) async {
    Response response = await spottersRepo.saveNote(Get.find<AuthController>().profileData!.id.toString(),notesListModel!.id.toString(),);
    if (response.statusCode == 200) {
      _bookmarkNoteList!.add(notesListModel);
      _bookmarkNoteIdList.add(notesListModel.id);
      showCustomSnackBar('Note Saved', isError: false);
      await _saveNoteBookmarks();
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
      await _saveNoteBookmarks();
    }
    update();
  }


  List<OsceModel?>? _osceBookmarkList = [];
  List<OsceModel?>? get osceBookmarkList => _osceBookmarkList;

  List<int?> _osceBookmarkIdList = [];
  List<int?> get osceBookmarkIdList => _osceBookmarkIdList;

  Future<void> _saveOsceBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert List<int?> to List<String> for saving
    List<String> bookmarkIds = _osceBookmarkIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_property_ids', bookmarkIds);
  }

  Future<void> _loadOsceBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_property_ids');
    if (savedIds != null) {
      // Convert List<String> back to List<int?>
      _osceBookmarkIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }


  void addOsceBookmark(String? userId,OsceModel? osceModel) async {
    Response response = await spottersRepo.saveOsce(Get.find<AuthController>().profileData!.id.toString(),osceModel!.id.toString(),);
    if (response.statusCode == 200) {
      _osceBookmarkList!.add(osceModel);
      _osceBookmarkIdList.add(osceModel.id);
      showCustomSnackBar('Osce Saved', isError: false);
      await _saveOsceBookmarks();
    }
    update();
  }

  void removeOsceBookmark(int? id,) async {
    Response response = await spottersRepo.saveOsce(Get.find<AuthController>().profileData!.id.toString(),id.toString());
    if (response.statusCode == 200) {
      int idIndex = -1;
      idIndex = _osceBookmarkIdList.indexOf(id);
      _osceBookmarkIdList.removeAt(idIndex);
      _osceBookmarkList!.removeAt(idIndex);
      getSavedOscePaginatedList('1');
      showCustomSnackBar('Osce Unsaved', isError: false);
      await _saveOsceBookmarks();
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


  bool _isSavedOsceLoading = false;

  bool get isSavedOsceLoading => _isSavedOsceLoading;

  List<OsceModel>? _savedOsceList;

  List<OsceModel>? get savedOsceList => _savedOsceList;
  Future<void> getSavedOscePaginatedList(String page) async {
    _isSavedOsceLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _savedOsceList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getOsceList(page,Get.find<AuthController>().profileData!.id.toString());

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<OsceModel> newDataList = dataList.map((json) =>
              OsceModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _savedOsceList = newDataList;
          } else {
            // Append data for subsequent pages
            _savedOsceList!.addAll(newDataList);
          }

          _isSavedOsceLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isSavedOsceLoading) {
          _isSavedOsceLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching saved osce list: $e');
      _isSavedOsceLoading = false;
      update();
    }
  }



  ///-----------------------------------------------------------


  List<CategoryNoteListModel?>? _bookmarkBasicList = [];
  List<CategoryNoteListModel?>? get bookmarkBasicList => _bookmarkBasicList;

  List<int?> _bookmarkBasicIdList = [];
  List<int?> get bookmarkBasicIdList => _bookmarkBasicIdList;


  Future<void> _saveBasicBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkIds = _bookmarkBasicIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_basic_ids', bookmarkIds);
  }

  Future<void> _loadBasicBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_basic_ids');
    if (savedIds != null) {
      _bookmarkBasicIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }

  void addBasicBookMarkList(String? userId,CategoryNoteListModel? notesListModel) async {
    Response response = await spottersRepo.saveBasic(Get.find<AuthController>().profileData!.id.toString(),notesListModel!.id.toString(),);
    if (response.statusCode == 200) {
      _bookmarkBasicList!.add(notesListModel);
      _bookmarkBasicIdList.add(notesListModel.id);
      showCustomSnackBar('Back To Basics Saved', isError: false);
      await _saveBasicBookmarks();
    }
    update();
  }

  void removeBasicBookMarkList(int? id,) async {
    Response response = await spottersRepo.saveBasic(Get.find<AuthController>().profileData!.id.toString(),id.toString());
    if (response.statusCode == 200) {
      int idIndex = -1;
      idIndex = _bookmarkBasicIdList.indexOf(id);
      _bookmarkBasicIdList.removeAt(idIndex);
      _bookmarkBasicList!.removeAt(idIndex);
      getSavedBasicPaginatedList('1');
      showCustomSnackBar('Note Unsaved', isError: false);
      await _saveBasicBookmarks();
    }
    update();
  }

  /// watch///


  List<CategoryNoteListModel?>? _bookmarkWatchList = [];
  List<CategoryNoteListModel?>? get bookmarkWatchList => _bookmarkWatchList;

  List<int?> _bookmarkWatchIdList = [];
  List<int?> get bookmarkWatchIdList => _bookmarkWatchIdList;

  Future<void> _saveWatchBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkIds = _bookmarkWatchIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_watch_ids', bookmarkIds);
  }

  Future<void> _loadWatchBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_watch_ids');
    if (savedIds != null) {
      _bookmarkWatchIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }

  void addWatchBookMarkList(String? userId, CategoryNoteListModel? watchListModel) async {
    Response response = await spottersRepo.saveWatch(Get.find<AuthController>().profileData!.id.toString(), watchListModel!.id.toString());
    if (response.statusCode == 200) {
      _bookmarkWatchList!.add(watchListModel);
      _bookmarkWatchIdList.add(watchListModel.id);
      showCustomSnackBar('Saved Successfully', isError: false);
      await _saveWatchBookmarks();
    }
    update();
  }

  void removeWatchBookMarkList(int? id) async {
    Response response = await spottersRepo.saveWatch(Get.find<AuthController>().profileData!.id.toString(), id.toString());
    if (response.statusCode == 200) {
      int idIndex = _bookmarkWatchIdList.indexOf(id);
      _bookmarkWatchIdList.removeAt(idIndex);
      _bookmarkWatchList!.removeAt(idIndex);
      getSavedWatchPaginatedList('1');
      showCustomSnackBar('Unsaved Successfully', isError: false);
      await _saveWatchBookmarks();
    }
    update();
  }

  /// munches //
  List<CategoryNoteListModel?>? _bookmarkMunchieList = [];
  List<CategoryNoteListModel?>? get bookmarkMunchieList => _bookmarkMunchieList;

  List<int?> _bookmarkMunchieIdList = [];
  List<int?> get bookmarkMunchieIdList => _bookmarkMunchieIdList;

  Future<void> _saveMunchieBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkIds = _bookmarkMunchieIdList.where((id) => id != null).map((id) => id!.toString()).toList();
    await prefs.setStringList('bookmarked_munchie_ids', bookmarkIds);
  }

  Future<void> _loadMunchieBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_munchie_ids');
    if (savedIds != null) {
      _bookmarkMunchieIdList = savedIds.map((id) => int.tryParse(id)).toList();
    }
    update();
  }

  void addMunchieBookMarkList(String? userId, CategoryNoteListModel? munchieListModel) async {
    Response response = await spottersRepo.saveMunchies(Get.find<AuthController>().profileData!.id.toString(), munchieListModel!.id.toString());
    if (response.statusCode == 200) {
      _bookmarkMunchieList!.add(munchieListModel);
      _bookmarkMunchieIdList.add(munchieListModel.id);
      showCustomSnackBar('Saved Successfully', isError: false);
      await _saveMunchieBookmarks();
    }
    update();
  }

  void removeMunchieBookMarkList(int? id) async {
    Response response = await spottersRepo.saveMunchies(Get.find<AuthController>().profileData!.id.toString(), id.toString());
    if (response.statusCode == 200) {
      int idIndex = _bookmarkMunchieIdList.indexOf(id);
      _bookmarkMunchieIdList.removeAt(idIndex);
      _bookmarkMunchieList!.removeAt(idIndex);
      getSavedMunchiesPaginatedList('1');
      showCustomSnackBar('Unsaved Successfully', isError: false);
      await _saveMunchieBookmarks();
    }
    update();
  }


  /// saved watches list ///

  bool _isSavedWatchLoading = false;

  bool get isSavedWatchLoading => _isSavedWatchLoading;

  List<CategoryNoteListModel>? _savedWatchList;
  List<CategoryNoteListModel>? get savedWatchList => _savedWatchList;
  Future<void> getSavedWatchPaginatedList(String page) async {
    _isSavedWatchLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _savedWatchList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await spottersRepo.getSavedWatchList(page,Get.find<AuthController>().profileData!.id.toString());

        if (response.statusCode == 200) {
          // Adjust the parsing to match the response structure
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<CategoryNoteListModel> newDataList = dataList.map((json) =>
              CategoryNoteListModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _savedWatchList = newDataList;
          } else {
            // Append data for subsequent pages
            _savedWatchList!.addAll(newDataList);
          }

          _isSavedWatchLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isSavedWatchLoading) {
          _isSavedWatchLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching saved osce list: $e');
      _isSavedWatchLoading = false;
      update();
    }
  }


  bool _isSavedMunchiesLoading = false;

  bool get isSavedMunchiesLoading => _isSavedMunchiesLoading;

  List<CategoryNoteListModel>? _savedMunchiesList;
  List<CategoryNoteListModel>? get savedMunchiesList => _savedMunchiesList;

  Future<void> getSavedMunchiesPaginatedList(String page) async {
    _isSavedMunchiesLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _savedMunchiesList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);
        Response response = await spottersRepo.getSavedMunchiesList(page,Get.find<AuthController>().profileData!.id.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<CategoryNoteListModel> newDataList = dataList.map((json) =>
              CategoryNoteListModel.fromJson(json)).toList();

          if (page == '1') {
            _savedMunchiesList = newDataList;
          } else {
            _savedMunchiesList!.addAll(newDataList);
          }
          _isSavedMunchiesLoading = false;
          update();
        } else {
        }
      } else {
        if (_isSavedMunchiesLoading) {
          _isSavedMunchiesLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching saved munchies list: $e');
      _isSavedMunchiesLoading = false;
      update();
    }
  }


  /// saved basic list ///

  bool _isSavedBasicLoading = false;

  bool get isSavedBasicLoading => _isSavedBasicLoading;

  List<CategoryNoteListModel>? _savedBasicList;
  List<CategoryNoteListModel>? get savedBasicList => _savedBasicList;

  Future<void> getSavedBasicPaginatedList(String page) async {
    _isSavedBasicLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _savedBasicList = [];
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);
        Response response = await spottersRepo.getSavedBasicList(page,Get.find<AuthController>().profileData!.id.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = response.body['data']['list'];
          List<dynamic> dataList = responseData['data'];
          List<CategoryNoteListModel> newDataList = dataList.map((json) =>
              CategoryNoteListModel.fromJson(json)).toList();

          if (page == '1') {
            _savedBasicList = newDataList;
          } else {
            _savedBasicList!.addAll(newDataList);
          }
          _isSavedBasicLoading = false;
          update();
        } else {
        }
      } else {
        if (_isSavedBasicLoading) {
          _isSavedBasicLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching saved basic list: $e');
      _isSavedBasicLoading = false;
      update();
    }
  }


}