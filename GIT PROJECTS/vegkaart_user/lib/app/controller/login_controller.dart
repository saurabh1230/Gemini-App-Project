import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vegkaart_customer/app/model/user_model.dart';
import 'package:vegkaart_customer/app/ui/dashboard_screen/dashboard_screen.dart';
import 'package:vegkaart_customer/app/ui/otp_verification_screen/otp_verification_screen.dart';
import 'package:vegkaart_customer/constant/constant.dart';
import 'package:vegkaart_customer/constant/send_notification.dart';
import 'package:vegkaart_customer/services/firebase_helper.dart';
import 'package:vegkaart_customer/services/notification_service.dart';
import 'package:vegkaart_customer/services/show_toast_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginController extends GetxController {
  Rx<TextEditingController> mobileNumberController = TextEditingController().obs;
  Rx<TextEditingController> countryCode = TextEditingController(text: "+91").obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  // Firebase user credential
  auth.UserCredential? userCredential;

  // Used to store the verification ID for OTP
  RxString verificationID = "".obs;

  // OTP related flag
  RxBool fromOTP = false.obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  // Get arguments if coming from OTP screen
  getArgument() async {
    dynamic argumentData = Get.arguments;

    if (argumentData != null) {
      print("Argument Data: $argumentData");

      if (argumentData['countryCode'] != null) {
        countryCode.value.text = argumentData['countryCode'];
      } else {
        print("Country Code is null");
      }

      if (argumentData['phoneNumber'] != null) {
        mobileNumberController.value.text = argumentData['phoneNumber'];
      } else {
        print("Phone Number is null");
      }

      if (argumentData["fromOTP"] != null) {
        fromOTP.value = argumentData["fromOTP"];
      } else {
        print("fromOTP is null");
      }

      if (argumentData["userCredentials"] != null) {
        userCredential = argumentData["userCredentials"];
      } else {
        print("User Credentials is null");
      }
    }
    update();
  }

  // Function to check if the user exists in Firestore
  Future<bool> checkUserExists(String mobileNumber) async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users') // Adjust the collection name if necessary
          .where('phoneNumber', isEqualTo: mobileNumber) // Assuming you store phone numbers in Firestore
          .limit(1)
          .get();

      return userDoc.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }


  sendCode() async {
    bool userExists = await checkUserExists(mobileNumberController.value.text);
    if (!userExists) {
      ShowToastDialog.showToast("User not registered. Please register first.".tr);
      return; // Do not proceed to send OTP
    }
    ShowToastDialog.showLoader("Please Wait".tr);
    await auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode.value.text + mobileNumberController.value.text,
      verificationCompleted: (auth.PhoneAuthCredential credential) {},
      verificationFailed: (auth.FirebaseAuthException e) {
        ShowToastDialog.closeLoader();
        if (e.code == 'invalid-phone-number') {
          ShowToastDialog.showToast("Invalid Phone Number");
        } else {
          ShowToastDialog.showToast(e.code);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        ShowToastDialog.closeLoader();

        verificationID.value = verificationId; // Store verification ID

        Get.to(OTPVerificationScreen(), arguments: {
          "countryCode": countryCode.value.text,
          "phoneNumber": mobileNumberController.value.text,
          "verificationId": verificationId,
          "fromSignup": true,
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).catchError((error) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("Error: ${error.toString()}".tr);
    });
  }

  verifyOTP(String otp) async {
    ShowToastDialog.showLoader("Verifying OTP...".tr);

    try {
      auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
        verificationId: verificationID.value,
        smsCode: otp,
      );

      userCredential = await auth.FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        // User successfully logged in
        Get.offAll(const DashBoardScreen());
      }

      ShowToastDialog.closeLoader();
    } catch (e) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("Invalid OTP".tr);
    }
  }
}
