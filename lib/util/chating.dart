import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Chating{
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getChatList(String userId) async {
    try {
      QuerySnapshot chatList = await db.collection('chat').where('userId', isEqualTo: userId).orderBy('lastChatDate', descending: true).get();
      for (QueryDocumentSnapshot chat in chatList.docs) {
        print(chat['chat']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendChat(String chat, String uid) async {
    try {
      await db.collection('chat').add({
        'chat': chat,
        'date': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}