import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u/model/program.dart';
import 'package:on_u/view/mainController.dart';

class ProgramDetailController extends MainController{
  late Program program;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    program = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
  }
}