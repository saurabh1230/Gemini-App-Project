
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../utils/dimensions.dart';

// void showCustomSnackBar(String? message, {bool isError = true}) {
//   Get.showSnackbar(GetSnackBar(
//     backgroundColor: isError ? Colors.red : Colors.green,
//     message: message,
//     duration: const Duration(seconds: 3),
//     snackStyle: SnackStyle.FLOATING,
//     margin: const EdgeInsets.all(Dimensions.paddingSize10),
//     borderRadius: 10,
//     isDismissible: true,
//     dismissDirection: DismissDirection.horizontal,
//   ));
// }

void showCustomSnackBar(String? message, {bool isError = true} ) {
  Fluttertoast.showToast(
    msg: message ?? "",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.white.withOpacity(0.60),
    // backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.black,
    fontSize: 16.0,
    timeInSecForIosWeb: 3,
  );
}