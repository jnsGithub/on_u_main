import 'package:cloud_firestore/cloud_firestore.dart';

class MyReservation {
  final String documentId;
  final String counselor;
  final String counselorInfo;
  final String myName;
  final String hp;
  final String request;
  final DateTime date;

  MyReservation({required this.documentId, required this.counselor, required this.counselorInfo, required this.myName, required this.hp, required this.request, required this.date});


  factory MyReservation.fromJson(Map<String, dynamic> json) {
    return MyReservation(
      documentId:json['documentId'] ?? '',
      counselor:json['counselor'] ?? '',
      counselorInfo:json['counselorInfo'] ?? '',
      myName:json['myName'] ?? '',
      hp:json['hp'] ?? '',
      request:json['request'] ?? '',
      date:json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['counselor'] = this.counselor;
    data['counselorInfo'] = this.counselorInfo;
    data['myName'] = this.myName;
    data['hp'] = this.hp;
    data['request'] = this.request;
    data['date'] = this.date;
    return data;
  }
}
