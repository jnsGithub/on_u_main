import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/chatRoom.dart';
import 'package:on_u/view/counselReservation/counselorDetail/counselorDetailController.dart';
import 'package:flutter/foundation.dart' as foundation;


class CounselorDetailView extends GetView<CounselorDetailController> {
  const CounselorDetailView({super.key});
  bool get isiOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
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
        body: SingleChildScrollView(
          child: Column(
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
                              onTap: () async {
                                try{
                                  print('1');
                                  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('chatRoom').where('userId', isEqualTo: uid!).where('counselorId', isEqualTo: controller.reservation.documentId).get();
                                  print('2');
                                  if(snapshot.docs.length == 0){
                                    print('3');
                                  }
                                  var chatRoomData = snapshot.docs[0].data() as Map<String, dynamic>;
                                  Get.toNamed('/chatRoomView',
                                      arguments: ChatRoom(
                                          documentId: '채팅룸 아이디임',
                                          counselorId: controller.reservation.documentId,
                                          userId: uid!,
                                          lastSenderId: chatRoomData['lastSenderId'],
                                          isReadUser: chatRoomData['isReadUser'],
                                          isReadCounselor: chatRoomData['isReadCounselor'],
                                          lastChatDate: chatRoomData['lastChatDate'].toDate(),
                                          counselorName: controller.reservation.name,
                                          counselorPhtoURL: controller.reservation.photoURL
                                      ));
                                }catch(e){
                                  print(e);
                                }
          
                              },
                              child: Container(
                                width: size.width*0.18,
                                height: 33,
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
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      bottomSheet: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: isiOS ? 20 : 25),
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
      ),
    );
  }
}
