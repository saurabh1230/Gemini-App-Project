
import 'package:get/get.dart';

import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/controllers/basic_controller.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/munchies_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/controllers/search_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/controllers/watch_controller.dart';
import 'package:radiology/data/api/api_client.dart';
import 'package:radiology/data/repo/auth_repo.dart';
import 'package:radiology/data/repo/basic_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/data/repo/watch_repo.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repo/munchies_repo.dart';


Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));


  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => NoteRepo(apiClient: Get.find()));
  Get.lazyPut(() => SpottersRepo(apiClient: Get.find()));
  Get.lazyPut(() => MunchiesRepo(apiClient: Get.find()));
  Get.lazyPut(() => WatchRepo(apiClient: Get.find()));
  Get.lazyPut(() => BasicRepo(apiClient: Get.find()));

  // Register controllers after repositories
  Get.lazyPut(() => AuthController(authRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => NotesController(noteRepo: Get.find()));
  Get.lazyPut(() => MunchiesController(munchiesRepo: Get.find()));
  Get.lazyPut(() => SpottersController(spottersRepo: Get.find()));
  Get.lazyPut(() => BookmarkController(spottersRepo: Get.find()));
  Get.lazyPut(() => BasicController(basicRepo: Get.find()));
  Get.lazyPut(() => WatchController(watchRepo: Get.find()));
  Get.lazyPut(() => SearchDataController(spottersRepo: Get.find()));
}

