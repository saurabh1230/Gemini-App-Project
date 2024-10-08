
import 'package:get/get.dart';
import 'package:radiology/features/screens/auth/signing_screen.dart';
import 'package:radiology/features/screens/auth/signup_screen.dart';
import 'package:radiology/features/screens/basics/basic_category_screen.dart';
import 'package:radiology/features/screens/basics/basic_page_dashboard.dart';
import 'package:radiology/features/screens/bookmark/bookmark_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_basic_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_munchies_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_notes_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_osce_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_watch_screen.dart';
import 'package:radiology/features/screens/home/home_screen.dart';
import 'package:radiology/features/screens/munchies/munches_notes_pages_dashboard.dart';
import 'package:radiology/features/screens/munchies/munchies_category_screen.dart';
import 'package:radiology/features/screens/notes/notes_pages_dashboard/notes_pages_dashboard.dart';
import 'package:radiology/features/screens/notes/notes_screen.dart';
import 'package:radiology/features/screens/osce/osce_screen.dart';
import 'package:radiology/features/screens/splash/splash_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_category_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_details_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_screen.dart';
import 'package:radiology/features/screens/watch/watch_category_screen.dart';
import 'package:radiology/features/screens/watch/watch_pages_dashboard.dart';

import '../features/screens/munchies/munchies_details_screen.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String homeScreen = '/home-screen';
  static const String notes = '/notes';
  static const String spotters = '/spotters';
  static const String notesDashboard = '/notes-dashboard';
  static const String munchesDashboard = '/munches-dashboard';
  static const String munchesDetails = '/munches-details';
  static const String basicDashboard = '/basic-dashboard';
  static const String watchDashboard = '/watch-dashboard';
  static const String forgotVerifyOtp = '/forgot-verify';
  static const String spottersDetails = '/spotters-details';
  static const String bookmark = '/bookmark';
  static const String savedNoteScreen = '/saved-note-screen';
  static const String savedWatchScreen = '/saved-watch-screen';
  static const String savedBasicScreen = '/saved-basic-screen';
  static const String savedMunchiesScreen = '/saved-munchies-screen';
  static const String osce = '/osce';
  static const String savedOsce = '/saved-osce';
  static const String munchiesCategory = '/munchies-category';
  static const String basicCategory = '/basic-category';
  static const String watchCategory = '/watch-category';





  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getHomeRoute() => homeScreen;
  static String getNotesRoute() => notes;
  static String getSpottersRoute() => spotters;
  static String getNotesDashboardRoute(String? categoryId,String? categoryName,) => '$notesDashboard?categoryId=$categoryId&categoryName=$categoryName';
  static String getMunchesDashboardRoute(String? categoryId,String? categoryName,) => '$munchesDashboard?categoryId=$categoryId&categoryName=$categoryName';
  static String getMunchesDetailsRoute(String? categoryId,String? categoryName,) => '$munchesDetails?categoryId=$categoryId&categoryName=$categoryName';
  static String getBasicDashboardRoute(String? categoryId,String? categoryName,) => '$basicDashboard?categoryId=$categoryId&categoryName=$categoryName';
  static String getWatchDashboardRoute(String? categoryId,String? categoryName,) => '$watchDashboard?categoryId=$categoryId&categoryName=$categoryName';
  static String getSpottersDetailsRoute(String? id,String? title,) => '$spottersDetails?spottersID=$id&title=$title';
  static String getBookmarkRoute() => bookmark;
  static String getSavedNoteScreen() => savedNoteScreen;
  static String getSavedWatchScreen() => savedWatchScreen;
  static String getSavedBasicScreen() => savedBasicScreen;
  static String getSavedMunchiesScreen() => savedMunchiesScreen;
  static String getOsceScreen() => osce;
  static String getSavedOsceScreen() => savedOsce;
  static String getMunchiesCategoryScreen() => munchiesCategory;
  static String getBasicCategoryScreen() => basicCategory;
  static String getWatchCategoryScreen() => watchCategory;





  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () =>  SignInScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: homeScreen, page: () =>  HomeScreen()),
    GetPage(name: notes, page: () =>  NotesScreen()),
    GetPage(name: spotters, page: () =>  SpottersScreen()),
    GetPage(name: notesDashboard, page: () =>  NotesDashboard(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: munchesDashboard, page: () =>  MunchesNotesDashboard(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: munchesDetails, page: () =>  MunchiesDetailScreen(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: basicDashboard, page: () =>  BasicNotesDashboard(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: watchDashboard, page: () =>  WatchNotesDashboard(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: spottersDetails, page: () =>  SpottersDetailsScreen(spottersId: Get.parameters['spottersID'],title:  Get.parameters['title'],)),
    GetPage(name: bookmark, page: () =>  BookmarkScreen()),
    GetPage(name: savedNoteScreen, page: () =>  SavedNoteScreen()),
    GetPage(name: savedWatchScreen, page: () =>  SavedWatchScreen()),
    GetPage(name: savedBasicScreen, page: () =>  SavedBasicScreen()),
    GetPage(name: savedMunchiesScreen, page: () =>  SavedMunchiesScreen()),
    GetPage(name: osce, page: () =>  OsceScreen()),
    GetPage(name: savedOsce, page: () =>  SavedOsceScreen()),
    GetPage(name: munchiesCategory, page: () =>  MunchiesCategoryScreen()),
    GetPage(name: basicCategory, page: () =>  BasicCategoryScreen()),
    GetPage(name: watchCategory, page: () =>  WatchCategoryScreen()),



  ];
}