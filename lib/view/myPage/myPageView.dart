import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/global.dart';

import '../../component/color/color.dart';
import '../mainController.dart';
import 'myPageController.dart';

class MyPageView extends GetView<MainController> {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.toNamed('/reservationListView', arguments: controller.counselorList);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: gray100)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('상담 예약 내역',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed('/contactUsView');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: gray100)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('문의하기',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launchUrl('https://www.naver.com');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: gray100)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('서비스 이용 약관',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launchUrl('https://www.naver.com');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: gray100)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('개인정보처리방침',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.offAllNamed('/loginView');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: gray100)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('로그아웃',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async{

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('회원탈퇴',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      Icon(Icons.navigate_next,color:gray200,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
