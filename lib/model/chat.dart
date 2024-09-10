import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String documentId;
  final Map<String, dynamic> chatList;
  final String counselor;
  String sender;
  bool isRead = false;
  final DateTime date;

  Chat({required this.documentId, required this.chatList, required this.counselor, required this.sender, required this.date});


  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      documentId:json['documentId'] ?? '',
      chatList:json['chatList'] ?? '',
      counselor:json['counselor'] ?? '',
      sender:json['sender'] ?? '',
      date:json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['chatList'] = this.chatList;
    data['counselor'] = this.counselor;
    data['sender'] = this.sender;
    data['date'] = this.date;
    return data;
  }
}
