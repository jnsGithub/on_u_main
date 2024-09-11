import 'package:cloud_firestore/cloud_firestore.dart';

class MyReservation {
  final String counselor;
  final String counselorInfo;
  final DateTime date;
  final String counselorPhotoUrl;

  MyReservation({
    required this.counselor,
    required this.counselorInfo,
    required this.date,
    required this.counselorPhotoUrl,
  });


  factory MyReservation.fromJson(Map<String, dynamic> json) {
    return MyReservation(
      counselor: json['counselor'] ?? '',
      counselorInfo: json['counselorInfo'] ?? '',
      date: json['date'].toDate(),
      counselorPhotoUrl: json['counselorPhotoUrl'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counselor'] = this.counselor;
    data['counselorInfo'] = this.counselorInfo;
    data['date'] = this.date;
    data['counselorPhotoUrl'] = this.counselorPhotoUrl;
    return data;
  }
}
