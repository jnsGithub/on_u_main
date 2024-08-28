import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool isAgree = false.obs;
  RxBool isAgree2 = false.obs;
  RxBool isComplete = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    passwordCheckController.addListener(_validateForm);
    isAgree.listen((_) => _validateForm());
    isAgree2.listen((_) => _validateForm());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    super.onClose();
  }

  void _validateForm() {
    // 조건: 이메일이 6자 이상, 비밀번호가 6자 이상일 때
    if (emailController.text != ''
        && passwordController.text != ''
        && passwordCheckController.text != ''
        && isAgree.value == true
        && isAgree2.value == true
        && passwordController.text == passwordCheckController.text) {
      isComplete.value = true;
    } else {
      isComplete.value = false;
    }
  }
}