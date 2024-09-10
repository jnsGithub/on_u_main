import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/view/counselReservation/counselorDetail/counselorDetailController.dart';


class CounselorDetailView extends GetView<CounselorDetailController> {
  const CounselorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CounselorDetailController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('상담예약', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(controller.reservation.photoURL),
                    fit: BoxFit.fitWidth,
                  ),
                  color: bgColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 28, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.reservation.name + ' 상담사', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            width: size.width*0.1385,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Color(0xffEAFFFB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(child: Text('채팅 상담', style: TextStyle(fontSize: 14, color: mainColor, fontWeight: FontWeight.w500),)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('전문 상담분야 | ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                        Text(controller.reservation.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: size.width,
                      child: Text(controller.reservation.body, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(padding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 30),
            child: GestureDetector(
              onTap: (){
                Get.toNamed('/reservaionCalendarView', arguments: controller.reservation);
              },
              child: Container(
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: Text('상담 예약하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),)),
              ),
            )
          ),
        ],
      )
    );
  }
}
