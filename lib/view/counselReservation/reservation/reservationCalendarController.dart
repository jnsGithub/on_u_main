import 'dart:ui';

import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';

class ReservationCalendarController extends GetxController {
  //TODO: 선택한 날짜에 파이어베이스 도큐먼트가 존재하지 않으면 reservationTimeCheck 전체를 true로 초기화하고 해당 날짜 도큐먼트를 생성해줘야함.
  //TODO: 도큐먼트의 키는 시간, 밸류는 bool타입으로 해야할듯.
  //TODO: 선택한 날짜에 파이어베이스 도큐먼트가 존재하면 reservationTimeCheck를 도큐먼트 값으로 초기화해줘야함.
  //TODO: 모델을 만드는게 수월할지? 아니면 그냥 리스트로 관리하는게 나을지?

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  RxInt selectedTime = 0.obs;
  Rx<Color> selectedColor = mainColor.obs;
  late DateTime selectReservation;

  List<String> reservationTime = ['08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00',
    '11:30', '12:00', '12:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00', '06:30', '07:00'];
  List<bool> reservationTimeCheck = [];
  bool isReservationTimeCheck = false;

  void selectedReservation(){
    var temp = selectedDay.value;
    selectReservation = temp;
    // selectReservation.hour =
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

  @override
  void onInit() {
    super.onInit();
    for(int i = 0; i < reservationTime.length; i++){
      isReservationTimeCheck = !isReservationTimeCheck;
      reservationTimeCheck.add(isReservationTimeCheck);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}