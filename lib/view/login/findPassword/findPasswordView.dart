import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/component/widget/textFieldWidget.dart';
import 'package:on_u/global.dart';
import 'package:on_u/view/login/findPassword/findPasswordController.dart';

class FindPasswordView extends GetView<FindPasswordController> {
  const FindPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FindPasswordController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 86, left: 16, bottom: 30, right: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '비밀번호 찾기',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                '비밀번호 찾기는 이메일 입력 시,\n가입하신 이메일을 통해 안내해 드립니다.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: gray600),
              ),
              const SizedBox(
                height: 43,
              ),
              TextFieldWidget(context, '이메일', size.width*0.9197, bgColor, mainColor, controller.emailController),
              SizedBox(height: 106,),
              ElevatedButton(
                onPressed: () async {
                  saving(context);
                  await controller.findPassword(controller.emailController.text);
                  if(controller.isSendMail){
                    Get.back();
                    Get.back();
                    if(!Get.isSnackbarOpen){
                      Get.snackbar('메일 발송 성공', '메일을 확인해주세요.',backgroundColor: mainColor, colorText: Colors.white);
                    }
                  }
                  else{
                    Get.back();
                    if(!Get.isSnackbarOpen){
                      Get.snackbar('메일 발송 실패', '이메일을 확인해주세요.',backgroundColor: const Color(0xffE52121), colorText: Colors.white);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  minimumSize: Size(size.width*0.9197, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text('메일 발송', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
