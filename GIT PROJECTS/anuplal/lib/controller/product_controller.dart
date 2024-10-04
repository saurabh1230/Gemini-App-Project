import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class ProductController extends GetxController implements GetxService {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<String> weightType = ['100 GM', '200 GM', '1 Kg', ];
  String _weightString = '';
  String get weightString => _weightString;
  void selectWeightString(String val) {
    _weightString = val;
    update();
  }




}