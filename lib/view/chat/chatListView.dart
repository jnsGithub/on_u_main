import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/chatRoom.dart';
import 'package:on_u/view/chat/chatListController.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatListController());
    return Scaffold(
      appBar: AppBar(
        title: Text('상담사 채팅'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chatRoom').where('userId', isEqualTo: uid!).orderBy('lastChatDate', descending: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print('채팅방 갯수 : ${snapshot.data!.docs.length}');
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                );
              },
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Duration difference = snapshot.data!.docs[index].data()['lastChatDate'].toDate().difference(DateTime.now()); // 시간, 분, 초를 나눠서 출력
                int  hours = difference.inHours < 0 ? difference.inHours.abs() : difference.inHours;  // 24시간을 넘는 부분은 나머지로 처리
                int minutes = difference.inMinutes.remainder(60) < 0 ? difference.inMinutes.remainder(60).abs() : difference.inMinutes.remainder(60);  // 60분을 넘는 부분은 나머지로 처리
                int seconds = difference.inSeconds.remainder(60) < 0 ? difference.inSeconds.remainder(60).abs() : difference.inMinutes.remainder(60);  // 60초를 넘는 부분은 나머지로 처리
                print('시간 : $hours, 분 : $minutes, 초 : $seconds');
                Map data = snapshot.data!.docs[index].data();
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      !snapshot.data!.docs[index].data()['isReadUser'] ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.circle,color: mainColor,size: 10,),
                      ) : Container(),
                      FutureBuilder<dynamic>(
                        future: controller.getCounselorInfo(data['counselorId']),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          else if (snapshot2.hasData) {
                            return ListTile(
                              onTap: () async {
                                await FirebaseFirestore.instance.collection('chatRoom').doc(snapshot.data!.docs[index].id).update({'isReadUser': true});
                                Get.toNamed(
                                    '/chatRoomView',
                                    arguments: ChatRoom(
                                        documentId: snapshot.data!.docs[index].id,
                                        counselorId: data['counselorId'],
                                        userId: data['userId'],
                                        lastSenderId: data['lastSenderId'],
                                        isReadUser: data['isReadUser'],
                                        isReadCounselor: data['isReadCounselor'],
                                        lastChatDate: data['lastChatDate'].toDate(),
                                        counselorName: snapshot2.data![0],
                                        counselorPhtoURL: snapshot2.data![1]
                                    )
                                );
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(snapshot2.data![1]),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot2.data![0] + ' 상담사', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!.docs[index].data()['lastChat'], style: TextStyle(color: gray700, fontSize: 14, fontWeight: FontWeight.w400),),
                                      Text(hours > 24 ? '${(hours/24).toInt()}일 전' : hours > 0 && hours < 24 ? '${hours}시간 전' : minutes > 0 ? '${minutes}분 전' : '${seconds}초 전', style: TextStyle(color: gray400, fontSize: 14, fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                          else{
                            return CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                            );
                          }
                        }
                      ),
                    ],
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

Widget a(){
  return ListView.separated(
    separatorBuilder: (context, index) {
      return Divider(
        color: Colors.grey,
        indent: 20,
        endIndent: 20,
      );
    },
    shrinkWrap: true,
    itemCount: 3, //controller.chatRoomList.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.circle,color: mainColor,size: 10,),
            ),
            ListTile(
              onTap: (){
                // Get.toNamed('/chatRoomView', arguments: controller.counselorList[index]);
              },
              leading: CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage(controller.chatRoomList[index].counselorPhtoURL),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(controller.chatRoomList[index].counselorName + ' 상담사', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('채팅 내용 미리보기 입니다.', style: TextStyle(color: gray700, fontSize: 14, fontWeight: FontWeight.w400),),
                      Text('1분', style: TextStyle(color: gray400, fontSize: 14, fontWeight: FontWeight.w400))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}