
import 'package:get/get.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void>   init() async {
  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));




  // Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));



  /// Controller
  Get.lazyPut(() => AuthController());

  // Get.lazyPut(() => PropertyMapController(latitude: null, longitude: null));


}
