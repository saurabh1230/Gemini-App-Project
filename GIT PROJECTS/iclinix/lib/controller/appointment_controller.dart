
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:iclinix/helper/date_converter.dart';

class AppointmentController extends GetxController implements GetxService {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DateTime? selectedDate;
  String? formattedDate;

  void updateDate(DateTime newDate) {
    selectedDate = newDate;
    formattedDate = SimpleDateConverter.formatDateToCustomFormat(selectedDate!);
    update();
  }

  int? selectedIndex;
  List<String> timeSlot = [
    '12:30 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM ',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
  ];

  void selectTimeSlot(int index) {
    selectedIndex = index;
    update();
  }

  var selectedGender = 'Male'; // Observable for selected gender
  final List<String> genderOptions = ['Male', 'Female', 'Other']; // List of options

  void updateGender(String gender) {
    selectedGender = gender; // Update selected gender
    update(); // Call update to refresh listeners (not using Obx)
  }



}