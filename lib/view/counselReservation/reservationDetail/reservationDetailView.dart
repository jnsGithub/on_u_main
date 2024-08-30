import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/counselReservation/reservationDetail/reservationDetailController.dart';

import '../../../component/color/color.dart';
import '../../../component/widget/textFieldWidget.dart';

class ReservationDetailView extends GetView<ReservationDetailController> {
  const ReservationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReservationDetailController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('상담 예약', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('상담을 위해 추가 정보를 입력해 주세요.', style: TextStyle(color: gray600, fontSize: 14, fontWeight: FontWeight.w400)),
              SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('상담 예약일', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Text('2024년 10월 14일', style: TextStyle(color: gray600, fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('상담 시간', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Text('오후 01:00', style: TextStyle(color: gray600, fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(height: 35),
              TextFieldWidget(context, '이름', size.width, bgColor, mainColor, controller.nameController),
              SizedBox(height: 30),
              TextFieldWidget(context, '전화번호', size.width, bgColor, mainColor, controller.hpController),
              SizedBox(height: 30),
              TextFieldWidget(context, '상담 전 요청사항 (선택)', size.width, bgColor, mainColor, controller.descriptionController, heith: 165, maxLines: 10),
              SizedBox(height: 34),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  minimumSize: Size(size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                  onPressed: (){},
                  child: Text('예약하기', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
