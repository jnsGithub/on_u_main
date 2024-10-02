import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_u/component/color/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:on_u/view/counselReservation/reservation/reservationCalendarController.dart';
import 'package:flutter/foundation.dart' as foundation;


class ReservationCalendarView extends GetView<ReservationCalendarController> {
  const ReservationCalendarView({super.key});
  bool get isiOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReservationCalendarController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '예약 날짜 선택',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(

        onRefresh: () async {
          print('새로고침됨');
          controller.refreshReservation();
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 20, top: 19, right: 20, bottom: isiOS ? 60 : 20),
              child: Stack(
                children: [Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: gray200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.only(top: 5, bottom: 20, left: 16, right: 16),
                      child: GetBuilder<ReservationCalendarController>(
                          builder: (controller) {
                            return TableCalendar(
                              selectedDayPredicate: (day) {
                                return isSameDay(controller.selectedDay.value, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                for(int i = 0; i < controller.holyday.length; i++){
                                  if(controller.holyday[i].year == selectedDay.year
                                      && controller.holyday[i].month == selectedDay.month
                                      && controller.holyday[i].day == selectedDay.day){
                                    return;
                                  }
                                }
                                controller.selectedDay.value = selectedDay;
                                // controller.focusedDay.value = focusedDay;
                                // controller.SelectDayRevervationPossibleTime(selectedDay);
                                controller.SelectDayRevervationPossibleTime(selectedDay);
                                controller.selectedTime.value = 99;
                                controller.update();
                              },
                              focusedDay: controller.focusedDay.value,
                              currentDay: DateTime.now(),
                              firstDay: DateTime.now(),
                              lastDay: DateTime.now().add(const Duration(days: 365)),
                              onPageChanged: (newFocusedDay) {
                                print(newFocusedDay);
                                final lastDay = DateTime.now().add(const Duration(days: 365));
                                // newFocusedDay를 firstDay와 lastDay 범위 내로 제한
                                if (newFocusedDay.isAfter(lastDay)) {
                                  controller.focusedDay.value = lastDay;
                                } else if (newFocusedDay.isBefore(DateTime.now())) {
                                  controller.focusedDay.value = DateTime.now();
                                } else {
                                  controller.focusedDay.value = newFocusedDay;
                                }

                              },
                              calendarBuilders: CalendarBuilders(

                                // holidayBuilder: (context, date, _) {
                                //   if(date.weekday == 6 || date.weekday == 7){
                                //     return Center(
                                //       child: Text(
                                //         date.day.toString(),
                                //         style: const TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.w400),
                                //       ),
                                //     );
                                //   }
                                //   return Center(
                                //     child: Text(
                                //       date.day.toString(),
                                //       style: const TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.w400),
                                //     ),
                                //   );
                                // },
                                // defaultBuilder: (context, date, _) {
                                //   if (date.month != DateTime.now().month) {
                                //     return SizedBox(); // 해당 월이 아닌 날짜는 빈 위젯으로 표시
                                //   }
                                //   return null; // 기본 설정을 그대로 사용
                                // },
                                headerTitleBuilder: (context, date) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${DateFormat.M('ko_KR').format(date) + ' ' +  DateFormat.y('ko_KR').format(date)}'
                                        , // 제목 표시
                                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.chevron_left, size: 40,),
                                            onPressed: () {
                                              controller.previousMonth();
                                              // controller.update();
                                            }, // 이전 달로 이동
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.chevron_right, size: 40,),
                                            onPressed: () {
                                              controller.nextMonth();
                                            }, // 다음 달로 이동
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                              locale: 'ko_KR',
                              daysOfWeekVisible: true,
                              weekNumbersVisible: false,
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false, // 포맷 버튼 숨기기
                                leftChevronVisible: false, // 왼쪽 화살표 숨기기
                                rightChevronVisible: false, // 오른쪽 화살표 숨기기
                                titleTextFormatter: (date, locale) =>
                                    DateFormat.yMMMM(locale).format(date),
                              ),
                              holidayPredicate: (day) { //TODO: 홀리데이 설정하는거임.
                                for(int i = 0; i < controller.holyday.length; i++){
                                  if(controller.holyday[i].year == day.year && controller.holyday[i].month == day.month && controller.holyday[i].day == day.day){
                                    return true;
                                  }
                                }
                                return false;
                                // if(day.weekday == 6 || day.weekday == 7){
                                //   return true;
                                // }
                                // return false;
                              },
                              calendarStyle: CalendarStyle(
                                rangeEndTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                defaultTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                weekendTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                holidayTextStyle: const TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold,),
                                holidayDecoration: const BoxDecoration(
                                  // color: Colors.red,
                                  // shape: BoxShape.circle,
                                ),
                                todayTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400),
                                todayDecoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                selectedTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                selectedDecoration: BoxDecoration(
                                  color: mainColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time_filled_sharp, color: Colors.black, size: 25,),
                            SizedBox(width: size.width*0.0256,),
                            Text('예약 시간 선택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle, color: gray300, size: 14,),
                            SizedBox(width: size.width*0.0154,),
                            Text('예약 불가', style: TextStyle(fontSize: 14, color: gray300, fontWeight: FontWeight.w500),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25,),
                    Text('오전', style: TextStyle(fontSize: 14, color: gray600, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12,),
                    GetBuilder<ReservationCalendarController>(
                        builder: (controller) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.reservationMorning.length,

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3/1.5,
                            ),

                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if(controller.selectedTime.value == index) {
                                    controller.selectedTime.value = 99;
                                    return;
                                  }
                                  else if(controller.totalReservationTimeCheck[index]){
                                    controller.selectedTime.value = index;
                                  }
                                  controller.stringToDate();
                                },
                                child: Obx(() => Container(
                                  width: size.width*0.1667,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:  controller.selectedTime.value == index? mainColor : controller.totalReservationTimeCheck[index] ? Color(0xffF6F6F9) : gray300,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: controller.selectedTime.value == index? mainColor : controller.totalReservationTimeCheck[index] ? gray200 : gray300),
                                  ),
                                  child: Text(controller.reservationMorning[index], style: TextStyle(
                                      fontSize: 14,
                                      color: controller.selectedTime.value == index? Colors.white : controller.totalReservationTimeCheck[index] ? Colors.black : gray200,
                                      fontWeight: FontWeight.w500),),
                                ),
                                ),
                              );
                            },
                          );
                        }
                    ),
                    SizedBox(height: 15,),
                    Text('오후', style: TextStyle(fontSize: 14, color: gray600, fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    GetBuilder<ReservationCalendarController>(
                        builder: (controller) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.reservationAfternoon.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3/1.5,
                            ),
                            itemBuilder: (context, index) {
                              int realIndex = index + 8;
                              return GestureDetector(
                                onTap: () {
                                  if(controller.selectedTime.value == realIndex){
                                    controller.selectedTime.value = 99;
                                    return;
                                  }
                                  else if(controller.totalReservationTimeCheck[realIndex]){
                                    controller.selectedTime.value = realIndex;
                                  }
                                  controller.stringToDate();
                                },
                                child: Obx(() => Container(
                                    width: size.width*0.1667,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:  controller.selectedTime.value == realIndex? mainColor : controller.totalReservationTimeCheck[realIndex] ? Color(0xffF6F6F9) : gray300,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: controller.selectedTime.value == realIndex? mainColor : controller.totalReservationTimeCheck[realIndex] ? gray200 : gray300),
                                    ),
                                    child: Text(controller.reservationAfternoon[index], style: TextStyle(
                                        fontSize: 14,
                                        color: controller.selectedTime.value == realIndex? Colors.white : controller.totalReservationTimeCheck[realIndex] ? Colors.black : gray200,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                ),

                              );
                            },
                          );
                        }
                    ),

                  ],
                ),
                ]
              )
          ),
        ),
      ),
      bottomSheet: Obx(() => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: isiOS ? 20 : 25),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isComplete.value ? mainColor : gray300,
              minimumSize: Size(size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              if(controller.isComplete.value == false){
                if(!Get.isSnackbarOpen){
                  Get.snackbar('알림', '예약 시간을 선택해주세요.');
                }
                return;
              }
              if(!await controller.checkReservation(controller.selectReservation)){
                if(!Get.isSnackbarOpen){
                  Get.snackbar('예약불가', '예약 시간 혹은 티켓이 부족합니다.');
                }
                return;
              }
              List<dynamic> reservationInfo = [controller.reservation.documentId, controller.selectReservation];
              Get.toNamed('/reservationDetailView', arguments: reservationInfo);
            },
            child: Text('예약하기', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
      ),
    );
  }
}
