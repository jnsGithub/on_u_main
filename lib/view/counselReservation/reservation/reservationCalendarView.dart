import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_u/component/color/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:on_u/view/counselReservation/reservation/reservationCalendarController.dart';

class ReservationCalendarView extends GetView<ReservationCalendarController> {
  const ReservationCalendarView({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 19, right: 20, bottom: 30),
            child: Column(
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
                            if( day.weekday == 6 || day.weekday == 7){
                              return false;
                            }
                            return isSameDay(controller.selectedDay.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            print('gdgd');
                            if(selectedDay.weekday != 6 && selectedDay.weekday != 7){
                              controller.selectedDay.value = selectedDay;
                              controller.focusedDay.value = focusedDay;
                            }
                            print(controller.selectedDay.value);
                            print(controller.focusedDay.value);

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
                          calendarStyle: CalendarStyle(
                            rangeEndTextStyle: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                            defaultTextStyle: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                            weekendTextStyle: const TextStyle(fontSize: 25.0, color: Colors.red, fontWeight: FontWeight.w400),
                            holidayTextStyle: const TextStyle(fontSize: 25.0, color: Colors.blue, fontWeight: FontWeight.w400),
                            todayTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400),
                            todayDecoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
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
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(controller.reservationTimeCheck[index]);
                        if(controller.reservationTimeCheck[index]){
                          controller.selectedTime.value = index;
                        }
                      },
                      child: Obx(() => Container(
                        width: size.width*0.1667,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:  controller.selectedTime.value == index? mainColor : controller.reservationTimeCheck[index] ? gray100 : gray300,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: controller.selectedTime.value == index? mainColor : controller.reservationTimeCheck[index] ? gray200 : gray300),
                        ),
                        child: Text(controller.reservationTime[index], style: TextStyle(
                            fontSize: 14,
                            color: controller.selectedTime.value == index? Colors.white : controller.reservationTimeCheck[index] ? Colors.black : gray200,
                            fontWeight: FontWeight.w500),),
                      ),
                      ),
                    );
                  },
                ),
                Text('오후', style: TextStyle(fontSize: 14, color: gray600, fontWeight: FontWeight.w500),),
                SizedBox(height: 12,),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 15,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    int realIndex = index + 8;
                    return GestureDetector(
                      onTap: () {
                        print(controller.reservationTimeCheck[realIndex]);
                        if(controller.reservationTimeCheck[realIndex]){
                          controller.selectedTime.value = realIndex;
                        }
                      },
                      child: Obx(() => Container(
                        width: size.width*0.1667,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:  controller.selectedTime.value == realIndex? mainColor : controller.reservationTimeCheck[realIndex] ? gray100 : gray300,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: controller.selectedTime.value == realIndex? mainColor : controller.reservationTimeCheck[realIndex] ? gray200 : gray300),
                        ),
                        child: Text(controller.reservationTime[realIndex], style: TextStyle(
                            fontSize: 14,
                            color: controller.selectedTime.value == realIndex? Colors.white : controller.reservationTimeCheck[realIndex] ? Colors.black : gray200,
                            fontWeight: FontWeight.w500),),
                      ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    minimumSize: Size(size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: (){
                    Get.toNamed('/reservationDetailView');
                  },
                  child: Text('예약하기', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            )
        ),
      ),
    );
  }
}
