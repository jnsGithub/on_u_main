import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/program/programController.dart';

import '../../component/color/color.dart';

class ProgramView extends GetView<ProgramController> {
  const ProgramView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(ProgramController());
    Size size = MediaQuery.of(context).size;
    int count = 0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: controller.programList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.toNamed('/programDetailView', arguments: controller.programList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width*0.9179,
                      height: 203,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(controller.programList[index].photoURL[0]),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(height: 14,),
                    Text(controller.programList[index].title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
