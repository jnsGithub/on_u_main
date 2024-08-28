import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';

import '../mainView.dart';
import 'loginController.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: size.width*0.5197, fit: BoxFit.fitWidth,),
              SizedBox(height: 30,),
              Image.asset('assets/images/subtitle.png', width: size.width*0.3308, fit: BoxFit.fitWidth,),
              SizedBox(height: 49.5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "이메일",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: size.width*0.9179,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: bgColor
                      ),
                    child: TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1.5,color: mainColor),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text(
                      "비밀번호",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: size.width*0.9179,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: bgColor),
                    child: TextField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width:1.5,color: mainColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed('/signUpCompanyView');
                    },
                    child: Text('회원가입', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                  ),
                  Text('  /  ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text('비밀번호 찾기', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: (){
                  Get.to(() => MainView());
                },
                child: Container(
                    width: size.width*0.9179,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: mainColor
                    ),
                  child: Center(
                    child: Text('로그인', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
