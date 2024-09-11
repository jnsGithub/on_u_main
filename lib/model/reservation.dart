import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u/model/reservationList.dart';

class Reservation {
  final String documentId;
  final String name;
  final String body;
  final String photoURL;
  final String profileURL;
  final String info;
  final String title;
  final List<DateTime> holyDate;
  final Map<String, dynamic> possibleTime;
  final List<ReservationList> reservationList;
  final DateTime date;



  Reservation({
    required this.documentId,
    required this.name,
    required this.body,
    required this.photoURL,
    required this.info,
    required this.title,
    required this.date,
    required this.profileURL,
    required this.possibleTime,
    required this.holyDate,
    required this.reservationList,
  });


  factory Reservation.fromJson(Map<String, dynamic> json) {
    print(json['reservationList']);
    print(json['reservationList'].runtimeType);
    List<DateTime> a = [];
    List<ReservationList> b = [];
    print('1');
    if(json['holyDate'] != null){
      for (var i in json['holyDate']){
        Timestamp b = i;
        a.add(b.toDate());
      }
    }
    print('2');
    if(json['reservationList'] != null){
      for (var i in json['reservationList']){
        b.add(ReservationList.fromJson(i));
      }
    }
    print('3');
    print('날짜 : {$a}');
      return Reservation(
        documentId:json['documentId'] ?? '',
        name:json['name'] ?? '',
        body:json['body'] ?? '',
        photoURL:json['photoURL'] ?? '',
        profileURL:json['profileURL'] ?? '',
        info: json['info'] ?? '',
        title:json['title'] ?? '',
        date:json['date'].toDate(),
        possibleTime:json['possibleTime'] ?? [],
        holyDate: a ?? [],
        reservationList: b ?? [],
      );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['profileURL'] = this.profileURL;
    data['info'] = this.info;
    data['title'] = this.title;
    data['date'] = this.date;
    data['possibleTime'] = this.possibleTime;
    data['holyDate'] = this.holyDate;
    data['reservationList'] = this.reservationList;
    return data;
  }
}
