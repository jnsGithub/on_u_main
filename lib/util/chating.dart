import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_u/model/chat.dart';
import 'package:on_u/model/chatRoom.dart';

class Chating{
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<ChatRoom>> getChatList(String userId) async {
    try {
      List<ChatRoom> chatRoomList = [];
      QuerySnapshot chatList = await db.collection('chatRoom').where('userId', isEqualTo: userId).orderBy('lastChatDate', descending: false).get();
      for (QueryDocumentSnapshot document in chatList.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        DocumentSnapshot counserlor = await db.collection('counselor').doc(data['counselorId']).get();
        Map<String, dynamic> counselorData = counserlor.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        data['counselorName'] = counselorData['name'];
        data['counselorPhtoURL'] = counselorData['photoURL'];
        chatRoomList.add(ChatRoom.fromJson(data));
      }
      return chatRoomList;
    } catch (e) {
      print(e);
      return[];
    }
  }

  Future<List<Chat>> getChat(String chatRoomId) async {
    try {
      List<Chat> chatList = [];
      QuerySnapshot chat = await db.collection('chat').where('chatRoomId', isEqualTo: chatRoomId).orderBy('date', descending: false).get();
      for (QueryDocumentSnapshot document in chat.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        chatList.add(Chat.fromJson(data));
      }
      return chatList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<String>> getcounselorInfo(String counselorId) async {
    try {
      List<String> counselorInfo = [];
      DocumentSnapshot counselor = await db.collection('counselor').doc(counselorId).get();
      Map<String, dynamic> data = counselor.data() as Map<String, dynamic>;
      counselorInfo.add(data['name']);
      counselorInfo.add(data['photoURL']);
      return counselorInfo;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> sendChat(String chatRoomId, String chat, String uid) async {
    try {
      await db.collection('chat').add({
        'chatRoomId' : chatRoomId,
        'chat': chat,
        'senderId': uid,
        'createDate': DateTime.now(),
      });
      await db.collection('chatRoom').doc(chatRoomId).update({
        'lastSenderId': uid,
        'lastChatDate': DateTime.now(),
        'lastChat': chat,
        'isReadUser': true,
        'isReadCounselor': false,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}