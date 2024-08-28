import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/view/reservation/reservationController.dart';

class ReservationView extends GetView<ReservationController> {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.83,
        ),
        itemCount: controller.reservationList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width*0.4385,
                height: size.width*0.4385,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 14,),
              Text(controller.reservationList[index].title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
            ],
          );
        },
      )
    );
  }
}
