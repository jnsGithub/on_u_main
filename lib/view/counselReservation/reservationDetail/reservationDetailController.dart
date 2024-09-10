import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/reservaionList.dart';
import 'package:on_u/util/reservationInfo.dart';
import 'package:on_u/view/counselReservation/counselorDetail/counselorDetailController.dart';

class ReservationDetailController extends GetxController{
  late DateTime reservationDate;
  late String reservationDateStr;
  late String reservationTime;

  TextEditingController nameController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<dynamic> reservationList = [];

  @override
  void onInit() {
    super.onInit();
    reservationList = Get.arguments;
    init();
    // reservationDate = Get.arguments;
  }
  @override
  void onClose(){
    super.onClose();
  }
  init(){
    String afterNoon = reservationList[1].hour >= 12 ? '오후' : '오전';
    reservationDateStr = reservationList[1].year.toString() + '년 ' + reservationList[1].month.toString() + '월 ' + reservationList[1].day.toString() + '일';
    if(reservationList[1].hour > 12) {
      if(reservationList[1].minute == 0){
        reservationTime = afterNoon + ' ' + ('0${reservationList[1].hour - 12}').toString() + ':' + '0${reservationList[1].minute.toString()}';
      }
      else{
        reservationTime = afterNoon + ' ' + ('0${reservationList[1].hour - 12}').toString() + ':' + reservationList[1].minute.toString();
      }
    }
    else{
      reservationTime = afterNoon + ' ' + DateFormat.Hm('ko_KR').format(reservationList[1]);
    }
  }

  void reservation(){
    ReservationInfo().addReservation(
        reservationList[0],
        ReservationList(
            name: nameController.text,
            hp: hpController.text,
            request: descriptionController.text,
            createDate: reservationList[1],
            counselorId: reservationList[0],
            userId: uid!,
            documentId: ''
        ),
        reservationList[1]);
  }
}