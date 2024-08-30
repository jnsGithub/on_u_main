import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/model/program.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/view/home/homeView.dart';
import 'package:on_u/view/myPage/myPageView.dart';
import 'package:on_u/view/program/programController.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/counselReservation/counselorListController.dart';
import 'package:on_u/view/counselReservation/counselorListView.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MainController extends GetxController {
  // 현재 선택된 탭의 인덱스를 저장
  var selectedIndex = 0.obs;
  RxInt pageIndex = 1.obs;
  String title = '';
  List<Program> programList = [];
  List<Reservation> reservationList = [];

  List<Color> exColor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.white,
    Colors.black,
    Colors.grey
  ];

  @override
  void onInit() {
    super.onInit();
    testAdd();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void testAdd(){
    programList.add(Program(
      title: '프로그램1',
      body: '건강과 지속 가능성을 추구하는 이들을 위해, 맛과 영양이 가득한 채식 요리 레시피를 소개합니다. 이 글에서는 간단하지만 맛있는 채식 요리 10가지를 선보입니다. 첫 번째 레시피는 아보카도 토스트, 아침 식사로 완벽하며 영양소가 풍부합니다. 두 번째는 콩과 야채를 사용한 푸짐한 채식 칠리, 포만감을 주는 동시에 영양소를 공급합니다. 세 번째는 색다른 맛의 채식 패드타이, 고소한 땅콩 소스로 풍미를 더합니다. 네 번째는 간단하고 건강한 콥 샐러드, 신선한 야채와 단백질이 가득합니다. 다섯 번째로는 향긋한 허브와 함께하는 채식 리조또, 크리미한 맛이 일품입니다. 여섯 번째는 에너지를 주는 채식 스무디 볼, 과일과 견과류의 완벽한 조합입니다. 일곱 번째는 건강한 채식 버거, 만족감 있는 식사를 제공합니다.',
      date: Timestamp.now(),
      documentId: '1',
      photoURL: ['https://picsum.photos/200/300'],
    ));
    programList.add(Program(
      title: '프로그램2',
      body: '프로그램2 내용',
      date: Timestamp.now(),
      documentId: '2',
      photoURL: ['https://picsum.photos/200/300'],
    ));
    programList.add(Program(
      title: '프로그램3',
      body: '프로그램3 내용',
      date: Timestamp.now(),
      documentId: '4',
      photoURL: ['https://picsum.photos/200/300'],
    ));

    reservationList.add(Reservation(
      title: '예약1',
      body: '예약1 내용',
      date: Timestamp.now(),
      documentId: '1',
      name: '홍길동',
      photoURL: 'https://picsum.photos/200/300',
    ));
    reservationList.add(Reservation(
      title: '예약2',
      body: '예약2 내용',
      date: Timestamp.now(),
      documentId: '2',
      name: '김철수',
      photoURL: 'https://picsum.photos/200/300',
    ));
    reservationList.add(Reservation(
      title: '예약3',
      body: '예약3 내용',
      date: Timestamp.now(),
      documentId: '3',
      name: '이영희',
      photoURL: 'https://picsum.photos/200/300',
    ));
    reservationList.add(Reservation(
      title: '예약4',
      body: '예약4 내용',
      date: Timestamp.now(),
      documentId: '4',
      name: '박철수',
      photoURL: 'https://picsum.photos/200/300',
    ));
    reservationList.add(Reservation(
      title: '예약5',
      body: '예약5 내용',
      date: Timestamp.now(),
      documentId: '5',
      name: '김영희',
      photoURL: 'https://picsum.photos/200/300',
    ));
  }

  // 선택된 인덱스에 따라 변경될 위젯을 반환하는 함수
  Widget get currentScreen {
    switch (selectedIndex.value) {
      case 0:
        return HomeView();
      case 1:
        var programController = Get.find<ProgramController>();
        programController.programList = programList;
        return ProgramView();
      case 2:
        var reservationController = Get.find<ReservationController>();
        reservationController.reservationList = reservationList;
        return CounselorListView();
      case 3:
        return PsychologicalTestView();
      case 4:
        return MyPageView();
      default:
        return HomeView();
    }
  }

  changeIndex(i){
    pageIndex.value = i;
  }

  // 탭 변경 함수
  changeTab(int index) {
    selectedIndex.value = index;
  }
}
