import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/model/program.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/view/home/homeView.dart';
import 'package:on_u/view/myPage/myPageView.dart';
import 'package:on_u/view/program/programController.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/reservation/reservationController.dart';
import 'package:on_u/view/reservation/reservationView.dart';

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
      body: '프로그램1 내용',
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
        return ReservationView();
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
