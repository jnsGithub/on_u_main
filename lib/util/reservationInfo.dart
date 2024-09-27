import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:on_u/global.dart';
import 'package:on_u/model/myReservaion.dart';
import 'package:on_u/model/reservationList.dart';
import 'package:on_u/model/reservation.dart';

class ReservationInfo{
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Reservation>>getCounselorList() async {
    List<Reservation> counselorList = [];
    try {
      QuerySnapshot snapshot = await db.collection('counselor').get();

      for (QueryDocumentSnapshot document in snapshot.docs) {

        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        // data['holyDate'] = data['holyDate'];
        // data['date'] = data['date'].toDate();
        // data['possibleTime'] = data['possibleTime'];
        data['reservationList'] = await getReservationList(document.id);
        counselorList.add(Reservation.fromJson(data));
      }
      return counselorList;
    } catch (e) {
      print('상담사 리스트 가져올때 걸림');
      print(e);
      return [];
    }
  }

  Future<Reservation> getCounselor(String documentId) async {
    try {
      List<ReservationList> reservationList = [];
      reservationList.addAll(await getReservationList(documentId));
      DocumentSnapshot snapshot = await db.collection('counselor').doc(documentId).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      data['holyDate'] = data['holyDate'];
      data['date'] = data['date'];
      data['possibleTime'] = data['possibleTime'];
      print('안됨?');
      data['reservationList'] = List<ReservationList>.from(reservationList);
      print('ㄴㄴ 됨ㅋㅋ');
      return Reservation.fromJson(data);
    } catch (e) {
      print('상담사 가져올때 걸림');
      print(e);
      return Reservation(
        documentId: '',
        name: '',
        body: '',
        photoURL: '',
        profileURL: '',
        info: '',
        title: '',
        date: DateTime.now(),
        possibleTime: {},
        holyDate: [],
        reservationList: [],
      );
    }
  }

  Future<List<MyReservation>> getMyReservationList() async {
    List<MyReservation> MyReservationList = [];
    try {
      QuerySnapshot snapshot = await db.collection('reservation').where('userId', isEqualTo: uid).orderBy('createDate', descending: true).get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> myReservationData = {};
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        QuerySnapshot snapshot2 = await db.collection('counselor').where('documentId', isEqualTo: data['counselorId']).get();
        myReservationData['counselor'] = snapshot2.docs[0]['name'];
        print(snapshot2.docs[0]['name']);
        myReservationData['counselorInfo'] = snapshot2.docs[0]['info'];
        print(snapshot2.docs[0]['info']);
        myReservationData['counselorPhotoUrl'] = snapshot2.docs[0]['photoURL'];
        print(snapshot2.docs[0]['photoURL']);
        myReservationData['date'] = data['createDate'];
        print(data['createDate']);
        MyReservationList.add(MyReservation.fromJson(myReservationData));
      }
      return MyReservationList;
    } catch (e) {
      print('예약내역 가져올때 걸림');
      print(e);
      return [];
    }
  }

  // 안쓰는중
  Future<List<ReservationList>> getReservationList(String counseloId) async {
    List<ReservationList> reservationList = [];
    try {
      QuerySnapshot snapshot = await db.collection('reservation').where('counselorId', isEqualTo: counseloId).get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        reservationList.add(ReservationList.fromJson(data));
      }
      return reservationList;
    } catch (e) {
      print('예약내역 가져올때 걸림');
      print(e);
      return [];
    }
  }

  Future<bool> checkReservation(String documentId, DateTime date) async {
    try {
      DocumentSnapshot snapshot = await db.collection('counselor').doc(documentId).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      Reservation reservation = Reservation.fromJson(data);
      for (var i in reservation.reservationList) {
        print(i.createDate);
        if (i.createDate.year == date.year
            && i.createDate.month == date.month
            && i.createDate.day == date.day
            && i.createDate.hour == date.hour
            && i.createDate.minute == date.minute) {
          return false;
        }
      }

      return true;
    } catch (e) {
      print('예약내역 체크할때 걸림');
      print(e);
      return false;
    }
  }


  // TODO : 예약 디비 수정해야함. ?? 했나?
  Future<void> addReservation(String documentId, ReservationList reservationList, DateTime date) async {
    try {
      Map<String, dynamic> data = reservationList.toJson();
      if(await checkReservation(documentId, date)) {
        await db.collection('reservation').add(data);
        Get.offAllNamed('/mainView');
      }
      else {
        if(!Get.isSnackbarOpen){
          Get.snackbar('알림', '이미 예약된 시간입니다.');
        }
      }
    } catch (e) {
      print('예약 추가할때 걸림');
      print(e);
    }
  }
}