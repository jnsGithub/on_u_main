import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/global.dart';
import 'package:on_u/view/chat/chatRoom/chatRoomController.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatRoomController());
    Size size = MediaQuery.of(context).size;
    print(controller.chatRoom.documentId);


    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chat').where('chatRoomId', isEqualTo: controller.chatRoom.documentId).orderBy('createDate', descending: false).snapshots(),
          builder: (context, snapshot) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.scrollController.hasClients) {
                controller.scrollToBottom();
              }
            });
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                print('zzzzzzzz s${controller.chatRoom.documentId}');
                print('gdgd ${snapshot.data!.docs.length}');
                Duration difference = snapshot.data!.docs[index]
                    .data()['createDate'].toDate().difference(
                    DateTime.now()); // 시간, 분, 초를 나눠서 출력
                int hours = difference.inHours < 0
                    ? difference.inHours.abs()
                    : difference.inHours; // 24시간을 넘는 부분은 나머지로 처리
                int minutes = difference.inMinutes.remainder(60) < 0
                    ? difference.inMinutes.remainder(60).abs()
                    : difference.inMinutes.remainder(60); // 60분을 넘는 부분은 나머지로 처리
                int seconds = difference.inSeconds.remainder(60) < 0
                    ? difference.inSeconds.remainder(60).abs()
                    : difference.inMinutes.remainder(60); // 60초를 넘는 부분은 나머지로 처리
                return Padding(
                  padding: snapshot.data!.docs[index].data()['senderId'] != uid
                      ? EdgeInsets.only(left: 10)
                      : EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data!.docs[index].data()['senderId'] != uid
                          ? Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      controller.chatRoom.counselorPhtoURL),
                                  fit: BoxFit.cover,
                                )
                            ),
                          )
                        ],
                      )
                          : Container(),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: snapshot.data!.docs[index]
                              .data()['senderId'] != uid ? CrossAxisAlignment
                              .start : CrossAxisAlignment.end,
                          children: [
                            snapshot.data!.docs[index].data()['senderId'] != uid
                                ? Text(controller.chatRoom.counselorName,
                              style: TextStyle(fontSize: 14,
                                  color: gray700,
                                  fontWeight: FontWeight.w400),)
                                : Container(),
                            SizedBox(height: 8,),
                            !snapshot.data!.docs[index].data()['chat'].contains('https://firebasestorage.googleapis.com/') ? ChatBubble(
                              clipper: ChatBubbleClipper5(
                                  type: snapshot.data!.docs[index]
                                      .data()['senderId'] != uid ? BubbleType
                                      .receiverBubble : BubbleType.sendBubble),
                              alignment: snapshot.data!.docs[index]
                                  .data()['senderId'] != uid
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              backGroundColor: snapshot.data!.docs[index]
                                  .data()['senderId'] != uid ? bgColor : Color(
                                  0xffE8F9F4),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.5, // 최대 너비 70% 설정
                                ),
                                child: SelectableLinkify(
                                  enableInteractiveSelection: true,
                                  onOpen: (link) async {
                                    if (await canLaunch(link.url)) {
                                      await launch(link.url);
                                    } else {
                                      throw 'Could not launch $link';
                                    }
                                  },
                                  text: snapshot.data!.docs[index].data()['chat'],
                                ),
                              ),
                            )
                            : Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: snapshot.data!.docs[index].data()['senderId'] != uid ? bgColor : Color(0xffE8F9F4),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.docs[index].data()['chat']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              hours > 24
                                  ? '${(hours / 24).toInt()}일 전'
                                  : hours > 0 && hours < 24
                                  ? '${hours}시간 전'
                                  : minutes > 0 ? '${minutes}분 전'
                                  : seconds > 0 ? '${seconds}초 전'
                                  : '방금',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: gray400,
                                  fontWeight: FontWeight.w400
                              ),
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: size.width,
        // height: 108,
        color: bgColor,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async { // TODO: 사진 불러오기 해야됨.
                    controller.pickImage();
                  },
                  icon: Icon(Icons.camera_alt, color: subColor)),
              Obx(() => Container(
                  width: size.width * 0.77,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      controller.selectedImage.value != null ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(controller.selectedImage.value!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: -10,
                              child: IconButton(
                                icon: Icon(Icons.close, color: Colors.grey),
                                onPressed: () {
                                  controller.selectedImage.value = null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ) : SizedBox(),
                      Expanded(
                        child: TextField(
                          controller: controller.chatController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 16),
                            hintText: '메시지를 입력해주세요',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      IconButton(
                        icon: Icon(Icons.send, color: subColor),
                        onPressed: () => controller.send(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget a(BuildContext context, ChatRoomController controller) {
  return ListView.builder(
    itemCount:controller.a.length,
    itemBuilder: (context, index) {
      return controller.a[index] ? Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(controller.chatRoom.counselorPhtoURL),
                        fit: BoxFit.cover,
                      )
                  ),
                )
              ],
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.chatRoom.counselorName, style: TextStyle(fontSize: 14, color: gray700, fontWeight: FontWeight.w400),),
                  SizedBox(height: 8,),
                  ChatBubble(
                    clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                    alignment: Alignment.topLeft,
                    backGroundColor: bgColor,
                    child: Linkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: "안녕하세요 https://www.naver.com",
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('1분 전', style: TextStyle(fontSize: 14, color: gray400, fontWeight: FontWeight.w400),),
                  SizedBox(height: 16,),
                ],
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ChatBubble(
              clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: Color(0xffE8F9F4),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  "감사합니다.",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text('1분 전', style: TextStyle(fontSize: 14, color: gray400, fontWeight: FontWeight.w400),),
            SizedBox(height: 16,),
          ],
        ),
      );
    },
  );
}
