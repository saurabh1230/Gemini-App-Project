import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:radiology/data/api/google_signin_api.dart';
import 'package:radiology/data/model/response/profile_data_model.dart';
import 'package:radiology/data/repo/auth_repo.dart';
import 'package:radiology/features/screens/forgot_password/forgot_password_set_new.dart';
import 'package:radiology/features/screens/forgot_password/forgot_password_verify_code.dart';
import 'package:radiology/features/widgets/custom_snackbar_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:google_sign_in/google_sign_in.dart';

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
        showCustomSnackBar('Login Failed Check Your Login Credentials', isError: true);
      } else {
        authRepo.saveUserToken(responseData['data']['access_token']);
        Get.offAllNamed(RouteHelper.getHomeRoute());
      }
      // showCustomSnackBar('Account Created Successfully', isError: false);
      _isLoginLoading = false;
      update();
    }else {
      _isLoginLoading = false;
      update();
    }
    _isLoginLoading = false;
    update();
  }

  bool _isforgotPassLoading = false;
  bool get isforgotPassLoading => _isforgotPassLoading;



  Future<void> forgotPassEmailApi(email) async {
    _isforgotPassLoading = true;
    update();
    Response response = await authRepo.forgotPassSendMail(email);
    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "success") {
        _isforgotPassLoading = false;
        String code = responseData['data']['code'].toString();
        showCustomSnackBar(code,);
        Get.back();
        Get.bottomSheet(
          ForgotPasswordVerifyCodeSheet(email:email,),
          backgroundColor:  Colors.white,
          isScrollControlled: true,
        );
        update();
        // return showCustomSnackBar('Login Failed Check Your Login Credentials', isError: true);
      } else {
      }
      // showCustomSnackBar('Network Error Please Try Later', isError: true);
      _isforgotPassLoading = false;
      update();
    }else {
      // showCustomSnackBar('Network Error Please Try Later', isError: true);
      _isforgotPassLoading = false;
      update();
    }
    _isforgotPassLoading = false;
    update();
  }

  Future<void> forgotPassOtpApi(code,email) async {
    _isforgotPassLoading = true;
    update();
    Response response = await authRepo.forgotPassOtpVerify(code, email);
    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "success") {
        _isforgotPassLoading = false;
        // String code = responseData['data']['code'].toString();
        showCustomSnackBar('Set New Password');
        Get.back();
        Get.bottomSheet(
          ForgotPasswordSetNewSheet(email:email, otp: code,),
          backgroundColor:  Colors.white,
          isScrollControlled: true,
        );
        update();
      } else {
        _isforgotPassLoading = false;
      }

      update();
    }else {
      _isforgotPassLoading = false;
      update();
    }
    _isforgotPassLoading = false;
    update();
  }


  Future<void> forgotPassResetApi(code,email,password,conPassword) async {
    _isforgotPassLoading = true;
    update();
    Response response = await authRepo.forgotPassReset(code, email, password, conPassword);
    if(response.statusCode == 200) {
      var responseData = response.body;
      if(responseData["status"]  == "success") {
        _isforgotPassLoading = false;
        // String code = responseData['data']['code'].toString();
        showCustomSnackBar('Password Changes Successfully');
        Get.back();
        // Get.bottomSheet(
        //   ForgotPasswordSetNewSheet(email:email, otp: code,),
        //   backgroundColor:  Colors.white,
        //   isScrollControlled: true,
        // );
        update();
        // return showCustomSnackBar('Login Failed Check Your Login Credentials', isError: true);
      } else {
      }
      // showCustomSnackBar('Network Error Please Try Later', isError: true);
      _isforgotPassLoading = false;
      update();
    }else {
      // showCustomSnackBar('Network Error Please Try Later', isError: true);
      _isforgotPassLoading = false;
      update();
    }
    _isforgotPassLoading = false;
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

  bool _googleLoading = false;
  bool get googleLoading => _googleLoading;
  final GoogleSignInApi api = GoogleSignInApi();

  Future<void> signInWithGoogle(String idToken) async {
    _googleLoading = true;
    update();

    var response = await api.get(idToken: idToken);
    if (response != null) {
      _googleLoading = false;
      update();
      var id = response['userFromDb']['id'];
      authRepo.saveUserToken(response['token']);
      print(id);
      // _userId = id;

      Get.offAndToNamed(RouteHelper.getHomeRoute());
      // Handle successful response
      print('Login successful: $response');
    } else {
      _googleLoading = false;
      update();
      // Handle error
      print('Login failed');
    }
  }


  ProfileModel? _profileData;
  ProfileModel? get profileData => _profileData;

  Future<ProfileModel?> getUserDetailsApi() async {
    _isLoading = true;
    _profileData = null;
    update();
    Response response = await authRepo.getUserData();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data']['list']; // Change List<dynamic> to Map<String, dynamic>
      _profileData = ProfileModel.fromJson(responseData);
    } else {

    }
    _isLoading = false;
    update();
    return _profileData;
  }


  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }
}


class GoogleSignInClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future logOut() => _googleSignIn.disconnect();

  Future<GoogleSignInAuthentication> login() async {
    GoogleSignInAuthentication auth;
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception();
    } else {
      auth = await account.authentication;
    }
    return auth;
  }
}