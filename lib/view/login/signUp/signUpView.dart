import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/widget/textFieldWidget.dart';
import 'package:on_u/view/login/signUp/signUpController.dart';

import '../../../component/color/color.dart';
import '../../../global.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => SignUpController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text('회원가입', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 28,left: 16, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('회원가입을 위해 아래 사항을 입력해주세요.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: gray600),),
                SizedBox(height: 21,),
                TextFieldWidget(context, '이메일', size.width*0.9197, bgColor, mainColor, controller.emailController),
                SizedBox(height: 35,),
                TextFieldWidget(context, '비밀번호', size.width*0.9197, bgColor, mainColor, controller.passwordController, isObscure: true),
                SizedBox(height: 35,),
                TextFieldWidget(context, '비밀번호 확인', size.width*0.9197, bgColor, mainColor, controller.passwordCheckController, isObscure: true),
                SizedBox(height: 40,),
                Text('약관동의', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                Obx(()=>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.isAgree.value = !controller.isAgree.value;
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: mainColor,
                                value: controller.isAgree.value,
                                onChanged: (value) {
                                  controller.isAgree.value = value!;
                                },
                              ),
                              const Text("서비스 이용 약관 동의",style: TextStyle(
                                  color: Color(0xff313740)
                              ),),
                              const Text(" (필수)",style: TextStyle(
                                  color: Color(0xffFF6A29)
                              ),),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){
                          // launchUrl('https://electric-fortnight-2a5.notion.site/Hero-7c69686297ee4ab287c7bd6e83864584?pvs=4');
                        }, icon: const Icon(Icons.navigate_next))
                      ],
                    ),
                ),
                Obx(()=>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.isAgree2.value = !controller.isAgree2.value;
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: mainColor,
                                value: controller.isAgree2.value,
                                onChanged: (value) {
                                  controller.isAgree2.value = value!;
                                },
                              ),
                              const Text("개인정보수집 및 이용 동의",style: TextStyle(
                                  color: Color(0xff313740)
                              ),),
                              const Text(" (필수)",style: TextStyle(
                                  color: Color(0xffFF6A29)
                              ),),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){
                          // launchUrl('https://electric-fortnight-2a5.notion.site/Hero-7c69686297ee4ab287c7bd6e83864584?pvs=4');
                        }, icon: const Icon(Icons.navigate_next))
                      ],
                    ),
                ),
              ],
            ),
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    controller.signUp();
                    if(controller.isSignUp){
                      Get.offAllNamed('/mainView');
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('환영합니다!', '회원가입이 완료되었습니다!ㄴ', backgroundColor: mainColor, colorText: Colors.white);
                      }
                    }
                    else if (controller.passwordController.text.length < 6){
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('회원가입 실패', '비밀번호를 6자리 이상 입력해주세요.', backgroundColor: const Color(0xffff0000), colorText: Colors.white);
                      }
                    }
                    else if(await controller.sign.checkEmail(controller.emailController.text) == false){
                    }
                    else{
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('회원가입 실패', '이메일 양식을 확인해주세요.', backgroundColor: const Color(0xffff0000), colorText: Colors.white);
                      }
                    }
                  },
                  child: Text('회원가입', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: controller.isComplete.value ? Colors.white : Colors.black),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.9197, 50),
                    backgroundColor: controller.isComplete.value ? mainColor : bgColor,
                    shadowColor: Colors.transparent,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
