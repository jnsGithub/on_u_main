import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/chat.dart';
import 'package:on_u/model/chatRoom.dart';
import 'package:on_u/model/reservation.dart';
import 'package:on_u/util/chating.dart';

class ChatRoomController extends GetxController{
  late ChatRoom chatRoom;
  List<bool> a = [true, false];

  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isUploading = false.obs; // 업로드 상태 관리
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  final ScrollController scrollController = ScrollController();
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

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  send() async {
    if(selectedImage.value != null && chatController.text != ''){
      if(await sendMsg(chatRoom.documentId, chatController.text, uid!)){
        uploadImageToFirebase();
        chatController.clear();
        scrollToBottom();
      }
      else{
        if(!Get.isSnackbarOpen){
          Get.snackbar('알림', '메시지 전송에 실패했습니다.', backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      }
      return;
    }
    if(selectedImage.value != null){
      uploadImageToFirebase();
      return;
    }
    if(chatController.text != ''){
      if(await sendMsg(chatRoom.documentId, chatController.text, uid!)){
        chatController.clear();
        scrollToBottom();
      }
      else{
        if(!Get.isSnackbarOpen){
          Get.snackbar('알림', '메시지 전송에 실패했습니다.', backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      }
    }

  }

  Future<void> pickImage() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  Future uploadImageToFirebase() async {
    if (selectedImage.value == null) return;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('chat_images').child(fileName);

      UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
      selectedImage.value = null;
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      saveImageUrlToFirestore(downloadUrl);
    } catch (e) {
      print('이미지 업로드 실패: $e');
    }
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('chat').add({
        'chat': imageUrl,
        'createDate': DateTime.now(),
        'chatRoomId': chatRoom.documentId,
        'senderId': uid,
      });
      print('이미지 URL이 Firestore에 저장되었습니다.');
    } catch (e) {
      print('이미지 URL 저장 실패: $e');
    }
  }

  sendMsg(String chatRoomId, String chat, String uid) async{
    return await chating.sendChat(chatRoomId, chat, uid);
  }
}