import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/widget/textFieldWidget.dart';
import 'package:on_u/view/login/signUp/signUpCompanyController.dart';

import '../../../component/color/color.dart';

class SignUpCompanyView extends GetView<SignUpCompanyController> {
  const SignUpCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => SignUpCompanyController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text('회원가입', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 28,left: 16, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('소속확인을 위한 절차에요', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: gray600),),
                SizedBox(height: 21,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('티켓 코드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                    SizedBox(height: 9,),
                    Row(
                      children: [
                        Obx(() => Container(
                            width: size.width*0.6795,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: bgColor
                            ),
                            child: TextField(
                              controller: controller.ticketController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: controller.isCompanyAuth.value ? mainColor : const Color(0xffE52121),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:1.5,color: controller.isCompanyAuth.value ? mainColor : const Color(0xffE52121)),
                                )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: () {
                            print('인증');
                            controller.isCompanyAuth.value = !controller.isCompanyAuth.value;
                          },
                          child: Text('인증', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            minimumSize: Size(size.width*0.2128, 50),
                            shadowColor: Colors.transparent,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Obx(() => !controller.isCompanyAuth.value ? Container(
                  padding: EdgeInsets.only(top: 6),
                  height: 35,
                  child: Text('확인되지 않은 티켓 코드입니다.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),),
                ) : SizedBox(height: 35,)),
                TextFieldWidget(context, '회사명', size.width*0.9197, bgColor, mainColor, controller.companyNameController),
                SizedBox(height: 35,),
                TextFieldWidget(context, '이름', size.width*0.9197, bgColor, mainColor, controller.nameController),
              ],
            ),
            Obx(() => ElevatedButton(
                  onPressed: (){
                    print('다음');
                    Get.toNamed('/signUpView');
                  },
                  child: Text('다음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: controller.isComplete.value ? Colors.white : Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isComplete.value ? mainColor : bgColor,
                  minimumSize: Size(size.width*0.9197, 50),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
