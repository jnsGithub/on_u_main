import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/model/chat.dart';
import 'package:on_u/model/chatRoom.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/chating.dart';

class ChatRoomController extends GetxController{
  late ChatRoom chatRoom;
  List<bool> a = [true, false];

  TextEditingController chatController = TextEditingController();

  Chating chating = Chating();

  @override
  void onInit() async{
    super.onInit();
    chatRoom = Get.arguments;
  }
  @override
  void onClose(){
    super.onClose();
  }

  sendMsg(String chatRoomId, String chat, String uid) async{
    return await chating.sendChat(chatRoomId, chat, uid);
  }
}