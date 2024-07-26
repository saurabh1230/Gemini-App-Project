import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/data/repo/auth_repo.dart';
import 'package:outlier_radiology_app/features/widgets/custom_snackbar_widget.dart';
import 'package:outlier_radiology_app/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart' as htmlParser;


class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthController({required this.authRepo,required this.sharedPreferences, }) ;

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }



  Future<void> onBackPressed() {
    return Get.dialog(
      AlertDialog(
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.exit_to_app_sharp),
            SizedBox(width: 10),
            Text(
              'Close Application?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text('Are you sure you want to exit the Application?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Get.back(result: false); // Will not exit the App
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  ///################ Apis ########################

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> registerApi(firstname,email,password,confirmPassword) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registerRepo(firstname, email, password, confirmPassword);

    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "error") {
        _isLoading = false;
        update();
        return showCustomSnackBar('Email is already taken try with new one', isError: true);

      } else {
        Get.offAllNamed(RouteHelper.getSignInRoute());
      }
      showCustomSnackBar('Account Created Successfully', isError: false);
      _isLoading = false;
      update();
    }else {

      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;
  Future<void> loginApi(username,password) async {
    _isLoginLoading = true;
    update();

    Response response = await authRepo.login(username, password);

    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "error") {
        _isLoginLoading = false;
        update();
        return showCustomSnackBar('Login Failed Check Your Login Credentials', isError: true);
      } else {
        authRepo.saveUserToken(responseData['data']['access_token']);
        Get.offAllNamed(RouteHelper.getHomeRoute());
      }
      showCustomSnackBar('Account Created Successfully', isError: false);
      _isLoginLoading = false;
      update();
    }else {
      _isLoginLoading = false;
      update();
    }
    _isLoginLoading = false;
    update();
  }

  Future<void> logoutApi() async {
    // _isLoginLoading = true;
    update();
    Response response = await authRepo.logOutApi();
    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "ok") {
        Get.offAllNamed(RouteHelper.getSignInRoute());
        Get.delete();
        // _isLoginLoading = false;
        update();
        return showCustomSnackBar('Logout Successfully', isError: false);
      } else {
        Get.offAllNamed(RouteHelper.getSignInRoute());
      }
      // showCustomSnackBar('Account Created Successfully', isError: false);
      // _isLoginLoading = false;
      update();
    }else {
      Get.offAllNamed(RouteHelper.getSignInRoute());
      // _isLoginLoading = false;
      update();
    }
    // _isLoginLoading = false;
    update();
  }


  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

}