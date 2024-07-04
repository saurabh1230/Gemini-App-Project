
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  Fluttertoast.showToast(
    msg: message!,
    toastLength: Toast.LENGTH_SHORT,
    gravity:  ToastGravity.TOP , // Use TOP_RIGHT for non-web platforms
    timeInSecForIosWeb: 1,
    // backgroundColor: Theme.of(context).primaryColor,
    textColor: Colors.white,
    webBgColor: isError ? "linear-gradient(to right, #ff0000, #ff7373)" : "linear-gradient(to right,#006400, #32CD32)",
    webPosition: "top_right", // Specify custom position for web
    fontSize: 16.0,
  );
}