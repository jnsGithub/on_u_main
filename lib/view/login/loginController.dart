import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u/util/sign.dart';

class LoginController extends GetxController {
  Sign sign = Sign();
  bool isSignIn = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future login() async {
    isSignIn = await sign.signIn(emailController.text, passwordController.text);
  }
}