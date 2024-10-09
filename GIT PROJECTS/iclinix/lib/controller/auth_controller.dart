import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:iclinix/app/widget/custom_snackbar.dart';
import 'package:iclinix/data/repo/auth_repo.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/date_converter.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthController({required this.authRepo,required this.sharedPreferences, }) ;

  DateTime? selectedDate;
  String? formattedDate;

  void updateDate(DateTime newDate) {
    selectedDate = newDate;
    formattedDate = SimpleDateConverter.formatDateToCustomFormat(selectedDate!);
    update();
  }

  var selectedGender = 'Male'; // Observable for selected gender
  final List<String> genderOptions = ['Male', 'Female',]; // List of options

  void updateGender(String gender) {
    selectedGender = gender; // Update selected gender
    update(); // Call update to refresh listeners (not using Obx)
  }

  var selectedDiabetes = 'No';
  final List<String> diabetesOptions = ['No','Yes']; // List of options

  void updateDiabetes(String val) {
    selectedDiabetes = val; // Update selected gender
    update(); // Call update to refresh listeners (not using Obx)
  }

  var selectedGlasses = 'No';
  final List<String> glassesOptions = ['No','Yes']; // List of options

  void updateGlasses(String val) {
    selectedGlasses = val; // Update selected gender
    update(); // Call update to refresh listeners (not using Obx)
  }

  var selectedBp= 'No';
  final List<String> bpOptions = ['No','Yes']; // List of options

  void updateHealth(String val) {
    selectedBp = val; // Update selected gender
    update(); // Call update to refresh listeners (not using Obx)
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DateTime? lastBackPressTime;

  Future<bool> handleOnWillPop() async {
    final now = DateTime.now();

    if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
      updateLastBackPressTime(now);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      SystemNavigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }
  void updateLastBackPressTime(DateTime time) {
    lastBackPressTime = time;
    update();
  }

  ///################ Apis ########################


  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  Future<void> sendOtpApi(String? phoneNo) async {
    _isLoginLoading = true;
    update();
    Response response = await authRepo.sendOtpRepo(phoneNo);
    if (response.statusCode == 200) {
      var responseData = response.body;
      if (responseData["message"].contains("OTP sent to your mobile number")) {
        String otp = responseData['otp'].toString();
        _isLoading = false;
        update();
        showCustomSnackBar(responseData['message'], isError: false);
        Get.toNamed(RouteHelper.getOtpVerificationRoute(phoneNo));
      } else {
        _isLoading = false;
        update();
        return showCustomSnackBar(responseData['message'], isError: true);
      }
    } else {
      _isLoginLoading = false;
      update();
      print('Failed to send OTP');
    }
    _isLoginLoading = false;
    update();
  }



  Future<void> verifyOtpApi(String? phoneNo, String? otp) async {
    _isLoginLoading = true;
    update();
    try {
      Response response = await authRepo.verifyOtp(phoneNo, otp);
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData != null && responseData.containsKey('token')) {
          authRepo.saveUserToken(responseData['token']);

          // Check if the user object exists and if the name field is present and not empty
          if (responseData.containsKey('user') &&
              responseData['user'].containsKey('name') &&
              responseData['user']['name'] != null &&
              responseData['user']['name']!.isNotEmpty) {
            // If name exists and is not empty, navigate to the dashboard
            Get.toNamed(RouteHelper.getDashboardRoute());
          } else {
            // If name does not exist or is empty, navigate to the Let's Begin screen
            Get.toNamed(RouteHelper.getLetsBeginRoute());
          }

          showCustomSnackBar('Verified Successfully', isError: true);
        } else if (responseData != null && responseData.containsKey('message')) {
          if (responseData["message"] == 'Invalid or expired OTP') {
            showCustomSnackBar(responseData["message"]);
          } else {
            showCustomSnackBar('Unexpected error: ${responseData["message"]}');
          }
        } else {
          showCustomSnackBar('Unexpected response format from server.');
        }
      } else {
        showCustomSnackBar('Failed to verify OTP. Please Try Again');
      }
    } catch (e) {
      showCustomSnackBar('An error occurred: $e');
    } finally {
      _isLoginLoading = false;
      update();
    }
  }






}