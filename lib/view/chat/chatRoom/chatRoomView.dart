import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:on_u/component/color/color.dart';
import 'package:on_u/view/chat/chatRoom/chatRoomController.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatRoomController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: ListView.builder(
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
                      ),
                    )
                  ],
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.counselor.name, style: TextStyle(fontSize: 14, color: gray700, fontWeight: FontWeight.w400),),
                      SizedBox(height: 8,),
                      ChatBubble(
                        clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                        alignment: Alignment.topLeft,
                        backGroundColor: bgColor,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            "안녕하세요 ㅋㅋ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
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
                  clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                  alignment: Alignment.topRight,
                  backGroundColor: Color(0xffE8F9F4),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      "안녕하세요 ㅋㅋ",
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: size.width,
        height: 108,
        color: bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt, color: subColor)),
            Container(
              alignment: Alignment.topCenter,
              width: size.width * 0.77,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                    onPressed: () {

                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget a(BuildContext context, ChatRoomController controller) {
  return Row(
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
            ),
          )
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.counselor.name, style: TextStyle(fontSize: 14, color: gray700, fontWeight: FontWeight.w400),),
            SizedBox(height: 8,),
            ChatBubble(
              clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: bgColor,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  "안녕하세요 ㅋㅋ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text('1분 전', style: TextStyle(fontSize: 14, color: gray400, fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    ],
  );
}