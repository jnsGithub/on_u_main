import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/view/program/programDetail/programDetailController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProgramDetailView extends GetView<ProgramDetailController> {
  const ProgramDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProgramDetailController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('프로그램 안내'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 28, right: 16, left: 16, bottom: 23),
              child: Text(controller.program.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
            ),
            SizedBox(
              height: 476,
              width: size.width,
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: 10,
                      controller: controller.pageController,
                      onPageChanged: (i){
                        controller.changeIndex(i+1);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width,
                          height: 214,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.exColor[index],
                            // image: DecorationImage(
                            //     image: NetworkImage(controller.banner[index]),
                            //     fit: BoxFit.cover
                            // )
                          ),
                        );
                      }),
                  Obx(() => Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.black54
                        ),
                        child: Text('${controller.pageIndex.value} / 10',style: TextStyle(color: Colors.white,fontSize: 13),
                        ),
                      )
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Center(
              child: SmoothPageIndicator(
                  controller: controller.pageController,  // PageController
                  count:  10,
                  effect: SwapEffect(
                    activeDotColor: mainColor,
                    dotColor: gray100,
                    dotWidth: 6,
                    dotHeight: 6,
                    type: SwapType.yRotation,
                  ),
                  // effect:  WormEffect(activeDotColor: mainColor, dotColor: gray100, dotWidth: 6, dotHeight: 6),  // your preferred effect
                  onDotClicked: (index){
                    controller.changeIndex(index);
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 30, right: 16, bottom: 30),
              child: Container(
                width: size.width,
                child: Text(controller.program.body, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
