import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpCompanyController extends GetxController {
  RxBool isCompanyAuth = false.obs;
  RxBool isComplete = false.obs;


  TextEditingController ticketController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    ticketController.addListener(changeListner);
    companyNameController.addListener(changeListner);
    nameController.addListener(changeListner);
    isCompanyAuth.listen((_) => changeListner());
    super.onInit();
  }

  @override
  void onClose() {
    ticketController.dispose();
    companyNameController.dispose();
    nameController.dispose();
    super.onClose();
  }

  void changeListner() {
    // 조건: 이메일이 6자 이상, 비밀번호가 6자 이상일 때
    if (ticketController.text != ''
        && companyNameController.text != ''
        && nameController.text != ''
        && isCompanyAuth.value == true) {
      isComplete.value = true;
    } else {
      isComplete.value = false;
    }
  }
}