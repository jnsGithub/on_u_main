import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/program.dart';

class ProgramController extends GetxController {
  RxList<Program> programList = <Program>[].obs;

  List<Color> exColor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.white,
    Colors.black,
    Colors.grey
  ];

  @override
  void onInit() {
    super.onInit();
    print(programList);
  }

  @override
  void onClose() {
    super.onClose();
  }
}