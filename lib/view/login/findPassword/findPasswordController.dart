import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u/util/sign.dart';

class FindPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Sign sign = Sign();
  bool isSendMail = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future findPassword(String email) async {
    isSendMail = await sign.findPassword(email);
  }
}