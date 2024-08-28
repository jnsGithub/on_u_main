import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String documentId;
  final String name;
  final String body;
  final String photoURL;
  final String title;
  final Timestamp date;

  Reservation({required this.documentId, required this.name, required this.body, required this.photoURL,required this.title, required this.date});


  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      documentId:json['documentId'] ?? '',
      name:json['name'] ?? '',
      body:json['body'] ?? '',
      photoURL:json['photoURL'] ?? '',
      title:json['title'] ?? '',
      date:json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
