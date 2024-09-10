import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/view/myPage/resrvationList/reservationListController.dart';

class ReservationListView extends GetView<ReservationListController> {
  const ReservationListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReservationListController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('상담 예약 내역', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          );
        },
        shrinkWrap: true,
        itemCount: controller.counselorList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('     ${controller.myReservationList[index].date}', style: TextStyle(fontSize: 13, color: gray700, fontWeight: FontWeight.w400),),
                    SizedBox(height: 5,),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: bgColor,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.myReservationList[index].counselor + ' 상담사', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.myReservationList[index].counselorInfo, style: TextStyle(color: gray700, fontSize: 14, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
