
import 'package:get/get.dart';

import 'package:outlier_radiology_app/controllers/auth_controller.dart';
import 'package:outlier_radiology_app/controllers/notes_controller.dart';
import 'package:outlier_radiology_app/controllers/spotters_controller.dart';
import 'package:outlier_radiology_app/data/api/api_client.dart';
import 'package:outlier_radiology_app/data/repo/auth_repo.dart';
import 'package:outlier_radiology_app/data/repo/note_repo.dart';
import 'package:outlier_radiology_app/data/repo/spotters_repo.dart';
import 'package:outlier_radiology_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void>   init() async {
  /// Repository

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));


  // Repository

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => NoteRepo(apiClient: Get.find(),));
  Get.lazyPut(() => SpottersRepo(apiClient: Get.find(),));


  /// Controller

  Get.lazyPut(() => AuthController(authRepo:  Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => NotesController(noteRepo:  Get.find()));
  Get.lazyPut(() => SpottersController(spottersRepo:  Get.find()));




}
