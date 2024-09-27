import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u/util/sign.dart';

class SignUpController extends GetxController {
  RxBool isAgree = false.obs;
  RxBool isAgree2 = false.obs;
  RxBool isComplete = false.obs;

  String companyCode = '';
  String companyName = '';
  String name = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  Sign sign = Sign();
  bool isSignUp = false;
  bool isEmailCheck = false;

  @override
  void onInit() {
    super.onInit();
    Set<String> arguments = Get.arguments as Set<String>;  // Set으로 캐스팅
    List<String> argumentList = arguments.toList();  // List로 변환
    companyCode = argumentList[0];
    companyName = argumentList[1];
    name = argumentList[2];

    print('companyCode: $companyCode');
    print('companyName: $companyName');
    print('name: $name');

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

  Future signUp() async {
    isSignUp = await sign.signUp(emailController.text, passwordController.text, passwordCheckController.text, companyCode, companyName, name);
  }

  void _validateForm() {
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