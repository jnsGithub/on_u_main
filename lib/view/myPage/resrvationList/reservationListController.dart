import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_u/model/myReservaion.dart';
import 'package:on_u/model/reservationList.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/reservationInfo.dart';

class ReservationListController extends GetxController {
  late List<Reservation> counselorList;
  RxList<MyReservation> myReservationList = <MyReservation>[].obs;
  List<ReservationList> reservationList = [];

  ReservationInfo reservationInfo = ReservationInfo();

  @override
  void onInit() async{
    super.onInit();
    await init();
    counselorList = Get.arguments;

  }

  @override
  void onClose() {
    super.onClose();
  }
  init() async{
    myReservationList.value = await reservationInfo.getMyReservationList();
    print(myReservationList.length);
  }

  String dateToString(DateTime date){
    String month = '';
    String day = '';
    String week = DateFormat.E('ko_KR').format(date);
    String afternoon = '';
    String hour = '';
    String min = '';
    if(date.month < 10) {
      month = '0${date.month}';
    }
    if(date.day < 10) {
      day = '0${date.day}';
    } else {
      day = '${date.day}';
    }
    if(date.hour > 12) {
      afternoon = '오후';
    } else {
      afternoon = '오전';
    }
    if(date.hour > 12) {
      hour = '${date.hour - 12}';
    } else {
      hour = '${date.hour}';
    }
    if(date.minute < 10) {
      min = '0${date.minute}';
    } else {
      min = '${date.minute}';
    }


    return '${month}.${day}(${week}) · ${afternoon} ${hour}시${min}분';
  }
}