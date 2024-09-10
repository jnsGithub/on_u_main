import 'dart:ui';

import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/model/reservaionList.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/reservationInfo.dart';
import 'package:on_u/view/mainController.dart';

class ReservationCalendarController extends GetxController {
  //TODO: 선택한 날짜에 파이어베이스 도큐먼트가 존재하지 않으면 reservationTimeCheck 전체를 true로 초기화하고 해당 날짜 도큐먼트를 생성해줘야함.
  //TODO: 도큐먼트의 키는 시간, 밸류는 bool타입으로 해야할듯.
  //TODO: 선택한 날짜에 파이어베이스 도큐먼트가 존재하면 reservationTimeCheck를 도큐먼트 값으로 초기화해줘야함.
  //TODO: 모델을 만드는게 수월할지? 아니면 그냥 리스트로 관리하는게 나을지?
  RxBool isComplete = false.obs;

  late Reservation reservation;
  ReservationInfo reservationInfo = ReservationInfo();

  RxBool isReservation = false.obs;

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  RxInt selectedTime = 99.obs;

  Rx<Color> selectedColor = mainColor.obs;
  late DateTime selectReservation;

  RxList<DateTime> holyday = <DateTime>[].obs;
  // RxList<DateTime> reservationDate = <DateTime>[].obs;

  List<String> reservationMorning = ['08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30'];
  List<String> reservationAfternoon = ['12:00', '12:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00', '06:30', '07:00'];

  List<String> totalReservationTime = [
    '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
    '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00'
  ];

  RxList<bool> reservationMorinigTimeCheck = RxList<bool>([true, true, true, true, true, true, true, true]);
  RxList<bool> reservationAfternoonTimeCheck = RxList<bool>([true ,true, true, true, true, true, true, true, true, true, true, true, true, true, true]);

  late RxList<bool> totalReservationTimeCheck = RxList<bool>([...reservationMorinigTimeCheck, ...reservationAfternoonTimeCheck]);

  List<ReservationList> reservationList = [];

  bool isReservationTimeCheck = false;

  // 휴일 설정
  defaultImpossibleTime(){
    for(int i = 0; i < reservation.possibleTime['morning']!.length; i++){
      for(int j = 0; j < reservationMorning.length; j++){
        if(reservation.possibleTime['morning']![i] == reservationMorning[j]){
          reservationMorinigTimeCheck[j] = false;
        }
      }
    }
    for(int i = 0; i < reservation.possibleTime['afternoon']!.length; i++){
      for(int j = 0; j < reservationAfternoonTimeCheck.length; j++){
        if(reservation.possibleTime['afternoon']![i] == reservationAfternoon[j]){
          reservationAfternoonTimeCheck[j] = false;
        }
      }
    }
  }

  setHolyDate(){
    for(int i = 0; i < reservation.holyDate.length; i++){
      holyday.add(reservation.holyDate[i]);
    }
    update();
  }

  SelectDayRevervationPossibleTime(DateTime selectedDay){
    this.selectedDay.value = selectedDay;
    reservationMorinigTimeCheck = RxList<bool>([true, true, true, true, true, true, true, true]);
    reservationAfternoonTimeCheck = RxList<bool>([true ,true, true, true, true, true, true, true, true, true, true, true, true, true, true]);
    defaultImpossibleTime();

    for (var i in reservation.reservationList) {
      if (i.createDate.month == this.selectedDay.value.month && i.createDate.day == this.selectedDay.value.day) {
        print('이거 탐');
        String reservationTime = '${i.createDate.hour > 12 ? '0${i.createDate.hour - 12}' : i.createDate.hour < 10 ? '0${i.createDate.hour}' : i.createDate.hour}:${i.createDate.minute == 0 ? '00' : '30'}';
        print(reservationTime);
        if (i.createDate.hour < 12) {
          int resrvationTimeIndex = reservationMorning.indexOf(reservationTime);
          print(resrvationTimeIndex);
          if (resrvationTimeIndex >= 0) {
            reservationMorinigTimeCheck[resrvationTimeIndex] = false;
          }
        } else {
          int resrvationTimeIndex = reservationAfternoon.indexOf(reservationTime);
          if (resrvationTimeIndex >= 0) {
            reservationAfternoonTimeCheck[resrvationTimeIndex] = false;
          }
        }
      }

    }
    totalReservationTimeCheck.value = [...reservationMorinigTimeCheck, ...reservationAfternoonTimeCheck];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    reservation = Get.arguments;
    setHolyDate();
    defaultImpossibleTime();
    SelectDayRevervationPossibleTime(selectedDay.value);
    totalReservationTimeCheck = RxList<bool>([...reservationMorinigTimeCheck, ...reservationAfternoonTimeCheck]);
    // print(DateFormat.Hm('ko_KR').format(DateTime.now()));
    selectedTime.listen((_) => changeListner());
  }

  @override
  void onClose() {
    super.onClose();
  }

  void refreshReservation() async{
    print(reservation.documentId);
    reservation = await reservationInfo.getCounselor(reservation.documentId);
    SelectDayRevervationPossibleTime(selectedDay.value);
    setHolyDate();
    // var mainController = Get.find<MainController>();
    // mainController.init();
  }

  // TODO: 현재 선택한 날짜와 시간이 예약 가능한지 체크
  Future<bool> checkReservation(DateTime selectedDay) async{
    return await reservationInfo.checkReservation(reservation.documentId, selectedDay);
  }

  // TODO: 선택한 날짜와 시간을 DateTime으로 변환
  void stringToDate(){
    if(selectedTime.value != 99){
      String hour = totalReservationTime[selectedTime.value].split(':')[0];
      String minute = totalReservationTime[selectedTime.value].split(':')[1];
      DateTime date = DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, int.parse(hour), int.parse(minute));
      print('시간 : ${date}');
      selectReservation = date;
    }
  }


  void previousMonth() {
    int month = focusedDay.value.month - 1;
    if(DateTime.now().month > month && DateTime.now().year == focusedDay.value.year) {
      if(!Get.isSnackbarOpen){
        Get.snackbar('알림', '이전달에는 예약을 할 수 없습니다.');
      }
      return;
    }
    focusedDay.value = DateTime(
      focusedDay.value.year,
      month,
      DateTime.now().month == focusedDay.value.month - 1 ? DateTime.now().day : 1,
    );
    update();
  }

  void nextMonth() {
    if(DateTime.now().year + 1 == focusedDay.value.year && DateTime.now().month == focusedDay.value.month){
      if(!Get.isSnackbarOpen){
        Get.snackbar('알림', '예약은 1년 이내로만 가능합니다.');
      }
      return;
    }
    focusedDay.value = DateTime(
      focusedDay.value.year,
      focusedDay.value.month + 1,
      1,
    );
    update();
  }

  void changeListner() {
    // 조건: 이메일이 6자 이상, 비밀번호가 6자 이상일 때
    if (selectedTime.value != 99) {
      isComplete.value = true;
    } else {
      isComplete.value = false;
    }
  }
}