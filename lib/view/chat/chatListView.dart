import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/component/color/color.dart';
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
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          );
        },
        shrinkWrap: true,
        itemCount: controller.counselorList.length,
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
                    Get.toNamed('/chatRoomView', arguments: controller.counselorList[index]);
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(controller.counselorList[index].profileURL),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.counselorList[index].name + ' 상담사', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),),
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
      ),
    );
  }
}
