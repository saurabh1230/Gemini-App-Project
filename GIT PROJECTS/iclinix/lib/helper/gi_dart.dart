//
// import 'package:get/get.dart';
//
//
//
// Future<void>   init() async {
//   /// Repository
//   final sharedPreferences = await SharedPreferences.getInstance();
//   Get.lazyPut(() => sharedPreferences);
//   Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
//
//
//
//
//   Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
//   Get.lazyPut(() => PropertyRepo(apiClient: Get.find()));
//   Get.lazyPut(() => LocationRepo(apiClient: Get.find()));
//   Get.lazyPut(() => VendorRepo(apiClient: Get.find()));
//   Get.lazyPut(() => InquiryRepo(apiClient: Get.find()));
//   Get.lazyPut(() => SearchRepo(apiClient: Get.find()));
//
//
//   /// Controller
//
//   Get.lazyPut(() => HomeController());
//   Get.lazyPut(() => ExploreController());
//   Get.lazyPut(() => PropertySearchController(searchRepo: Get.find()));
//   Get.lazyPut(() => ProfileController(profileRepo: Get.find(), apiClient: Get.find()));
//   Get.lazyPut(() => AuthController(authRepo:  Get.find(),sharedPreferences: Get.find()));
//   Get.lazyPut(() => PropertyController(propertyRepo:  Get.find()));
//   Get.lazyPut(() => LocationController(locationRepo:  Get.find()));
//   Get.lazyPut(() => VendorController(vendorRepo:  Get.find()));
//   Get.lazyPut(() => BookmarkController(propertyRepo:  Get.find()));
//   Get.lazyPut(() => BookmarkController(propertyRepo:  Get.find()));
//   Get.lazyPut(() => InquiryController(inquiryRepo:  Get.find()));
//   Get.lazyPut(() => MapController());
//   Get.lazyPut(() => VendorMapController());
//   Get.lazyPut(() => UserMapController());
//   // Get.lazyPut(() => PropertyMapController(latitude: null, longitude: null));
//
//
// }
