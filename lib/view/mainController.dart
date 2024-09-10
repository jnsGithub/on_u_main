import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/model/program.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/programInfo.dart';
import 'package:on_u/view/home/homeView.dart';
import 'package:on_u/view/myPage/myPageView.dart';
import 'package:on_u/view/program/programController.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/counselReservation/counselorListController.dart';
import 'package:on_u/view/counselReservation/counselorListView.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/reservationInfo.dart';

class MainController extends GetxController {
  // 현재 선택된 탭의 인덱스를 저장
  var selectedIndex = 0.obs;
  RxInt pageIndex = 1.obs;
  String title = '';
  late RxList<Program> programList = <Program>[].obs;
  late RxList<Reservation> counselorList = <Reservation>[].obs;

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
  void onInit() async {
    super.onInit();
    await init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async{
    counselorList.value = await ReservationInfo().getCounselorList();
    programList.value = await ProgramInfo().getProgram();
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
        reservationController.reservationList = counselorList;
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
