import 'package:cloud_firestore/cloud_firestore.dart';

class Program {
  final String documentId;
  final String body;
  final List<String> photoURL;
  final String title;
  final Timestamp date;

  Program({required this.documentId, required this.body, required this.photoURL,required this.title, required this.date});


  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      documentId:json['documentId'] ?? '',
      body:json['body'] ?? '',
      photoURL:json['photoURL'] ?? '',
      title:json['title'] ?? '',
      date:json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
