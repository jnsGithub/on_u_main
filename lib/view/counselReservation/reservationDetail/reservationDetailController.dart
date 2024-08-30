import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReservationDetailController extends GetxController{
  late DateTime reservationDate;
  late String reservationDateStr;
  late String reservationTime;

  TextEditingController nameController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    // reservationDate = Get.arguments;
  }
  @override
  void onClose(){
    super.onClose();
  }
  init(){
    String afterNoon = reservationDate.hour > 12 ? '오후' : '오전';
    reservationDateStr = reservationDate.year.toString() + '년 ' + reservationDate.month.toString() + '월 ' + reservationDate.day.toString() + '일';
    reservationTime = afterNoon + ' ' + DateFormat.Hm('ko_KR').format(reservationDate);
  }

}