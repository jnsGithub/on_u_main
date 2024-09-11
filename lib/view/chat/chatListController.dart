import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/chatRoom.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/chating.dart';

class ChatListController extends GetxController {
  late List<ChatRoom> chatRoomList = [];



  Chating chating = Chating();

  List<String> counselorInfo = [];

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }

  getCounselorInfo(String counselorId) async {
    return await chating.getcounselorInfo(counselorId);
  }
}