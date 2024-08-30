import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/counselReservation/counselorListView.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../component/color/color.dart';
import 'home/homeView.dart';
import 'mainController.dart';
import 'myPage/myPageView.dart';


class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Obx(() => controller.selectedIndex == 0 ?
        Image.asset('assets/images/logo.png', width: size.width*0.2051,fit: BoxFit.fitWidth,)
            : Text(controller.title, style: TextStyle(color: mainColor, fontSize: 22, fontWeight: FontWeight.w600)
        ),
        ),
        actions: [
          IconButton(
            icon: ImageIcon(AssetImage('assets/images/sms.png'), color: subColor, size: 24),
            onPressed: () {
              Get.toNamed('/chatListView', arguments: controller.counselorList);
            },
          ),
        ],
      ),
      body: Obx(() => controller.currentScreen), // 현재 화면을 그리도록 설정
      // body: Obx(() => IndexedStack(
      //   index: controller.selectedIndex.value,
      //   children: [
      //     HomeView(),
      //     ProgramView(),
      //     ReservationView(),
      //     PsychologicalTestView(),
      //     MyPageView(),
      //   ],
      // )),
      // bottomNavigationBar: Obx(() => a('title', 'iconPath', 0)),
      bottomNavigationBar: Container(
        height: 86,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Obx(() => Row(
          children: [
            Expanded(
              child: bottomNaviItem('홈', 'assets/images/home.png', 0),
            ),
            Expanded(
              child: bottomNaviItem('프로그램', 'assets/images/bubble_chart.png', 1),
            ),
            Expanded(
              child: bottomNaviItem('상담예약', 'assets/images/priority.png', 2),
            ),
            Expanded(
              child: bottomNaviItem('심리검사', 'assets/images/history_edu.png', 3),
            ),
            Expanded(
              child: bottomNaviItem('마이페이지', 'assets/images/person.png', 4),
            ),
          ],
        )),
      ),
    );
  }

  Widget bottomNaviItem(String title, String iconPath, int index) {
    Color color = controller.selectedIndex.value == index ? mainColor : gray100;

    return GestureDetector(
      onTap: () {
        controller.changeTab(index);
        if(index == 1){
          controller.title = 'ON:U 프로그램';
        }
        else if(index == 2){
          controller.title = '상담예약';
        }
        else if(index == 3){
          controller.title = '심리검사';
        }
        else if(index == 4){
          controller.title = '마이페이지';
        }
        else {
          controller.title = '';
        }
        print(title);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, color: color, height: 24),
          SizedBox(height: 4),
          Text(title, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget a(String title, String iconPath, int index) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: StylishBottomBar(
        option: AnimatedBarOptions(
          iconSize: 32,
          iconStyle: IconStyle.Default,
          opacity: 0.3,
          // barAnimation: BarAnimation.fade,
        ),
        items: [
          BottomBarItem(
              icon: Image.asset('assets/images/home.png', color: controller.selectedIndex == 0 ? mainColor : gray100, height: 24),
              title: const Text('홈'),
              backgroundColor: mainColor,
              unSelectedColor: gray100,
          ),
          BottomBarItem(
              icon: Image.asset('assets/images/bubble_chart.png', color: controller.selectedIndex == 1 ? mainColor : gray100, height: 24),
              title: const Text('프로그램'),
              backgroundColor: mainColor,
              unSelectedColor: gray100
          ),
          BottomBarItem(
              icon: Image.asset('assets/images/priority.png', color: controller.selectedIndex == 2 ? mainColor : gray100, height: 24),
              title: const Text('상담예약'),
              backgroundColor: mainColor,
              unSelectedColor: gray100
          ),
          BottomBarItem(
              icon: Image.asset('assets/images/history_edu.png', color: controller.selectedIndex == 3 ? mainColor : gray100, height: 24),
              title: const Text('심리검사'),
              backgroundColor: mainColor,
              unSelectedColor: gray100
          ),
          BottomBarItem(
              icon: Image.asset('assets/images/person.png', color: controller.selectedIndex == 4 ? mainColor : gray100, height: 24),
              title: const Text('마이페이지'),
              backgroundColor: mainColor,
              unSelectedColor: gray100
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: false,
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.changeTab(index);
          if(index == 1){
            controller.title = 'ON:U 프로그램';
          }
          else if(index == 2){
            controller.title = '상담예약';
          }
          else if(index == 3){
            controller.title = '심리검사';
          }
          else if(index == 4){
            controller.title = '마이페이지';
          }
          else {
            controller.title = '';
          }
          print(title);
        },
      ),
    );
  }
}
