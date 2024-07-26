
import 'package:get/get.dart';
import 'package:radiology/features/screens/auth/signing_screen.dart';
import 'package:radiology/features/screens/auth/signup_screen.dart';
import 'package:radiology/features/screens/bookmark/bookmark_screen.dart';
import 'package:radiology/features/screens/bookmark/saved_notes_screen.dart';
import 'package:radiology/features/screens/home/home_screen.dart';
import 'package:radiology/features/screens/notes/notes_pages_dashboard/notes_pages_dashboard.dart';
import 'package:radiology/features/screens/notes/notes_screen.dart';
import 'package:radiology/features/screens/splash/splash_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_category_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_details_screen.dart';
import 'package:radiology/features/screens/spotters/spotters_screen.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String homeScreen = '/home-screen';
  static const String notes = '/notes';
  static const String spotters = '/spotters';
  static const String notesDashboard = '/notes-dashboard';
  static const String forgotVerifyOtp = '/forgot-verify';
  static const String spottersDetails = '/spotters-details';
  static const String bookmark = '/bookmark';
  static const String savedNoteScreen = '/saved-note-screen';
  // static const String spottersCategory = '/spotters-category';



  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getHomeRoute() => homeScreen;
  static String getNotesRoute() => notes;
  static String getSpottersRoute() => spotters;
  static String getNotesDashboardRoute(String? categoryId,String? categoryName,) => '$notesDashboard?categoryId=$categoryId&categoryName=$categoryName';
  static String getSpottersDetailsRoute(String? id,String? title,) => '$spottersDetails?spottersID=$id&title=$title';
  static String getBookmarkRoute() => bookmark;
  static String getSavedNoteScreen() => savedNoteScreen;





  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () =>  SignInScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: homeScreen, page: () =>  HomeScreen()),
    GetPage(name: notes, page: () =>  NotesScreen()),
    GetPage(name: spotters, page: () =>  SpottersScreen()),
    GetPage(name: notesDashboard, page: () =>  NotesDashboard(categoryId: Get.parameters['categoryId'],categoryName: Get.parameters['categoryName'],)),
    GetPage(name: spottersDetails, page: () =>  SpottersDetailsScreen(spottersId: Get.parameters['spottersID'],title:  Get.parameters['title'],)),
    GetPage(name: bookmark, page: () =>  BookmarkScreen()),
    GetPage(name: savedNoteScreen, page: () =>  SavedNoteScreen()),



  ];
}