import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/mainController.dart';

import '../../component/color/color.dart';

class HomeView extends GetView<MainController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 25, right: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ON:U 프로그램", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,)),
                    GestureDetector(
                      onTap: (){
                        controller.selectedIndex.value = 1;
                      },
                      child: Text("더보기 >", style: TextStyle(fontSize: 13, color: gray500, fontWeight: FontWeight.w500,),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 214,
                width: size.width,
                child: Stack(
                  children: [
                    PageView.builder(
                        itemCount: 10,
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
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 25, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "간편 심리검사(가칭)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.selectedIndex.value = 2;
                          },
                          child: Text(
                            "더보기 >",
                            style: TextStyle(
                              fontSize: 13,
                              color: gray500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: size.width*0.45,
                      width: size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){

                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width*0.3333,
                                    height: size.width*0.3333,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: controller.exColor[index],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('ABC 테스트')
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "상담 예약",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.selectedIndex.value = 3;
                          },
                          child: Text(
                            "더보기 >",
                            style: TextStyle(
                              fontSize: 13,
                              color: gray500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: size.width*0.45,
                      width: size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.reservationList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Get.toNamed('/counselorDetailView', arguments: controller.reservationList[index]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width*0.3333,
                                    height: size.width*0.3333,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: controller.exColor[index],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(controller.reservationList[index].name)
                                ],
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 105,
                width: size.width,
                color: bgColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('(주)리허그', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: gray500),),
                      SizedBox(height: 8,),
                      Text('대표 한재원 | 사업자 등록번호 619-86-02878', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: gray500),),
                      SizedBox(height: 8,),
                      Text('서울 서초구 청계산로 203, 507호', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: gray500, ),),
                      SizedBox(height: 8,),
                      Text('고객센터 000-0000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: gray500),),
                    ],
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
