import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u/model/reservaionList.dart';
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
        counselorList.add(Reservation.fromJson(data));
      }
      return counselorList;
    } catch (e) {
      print('상담사 가져올때 걸림');
      print(e);
      return [];
    }
  }

  Future<Reservation> getCounselor(String documentId) async {
    try {
      DocumentSnapshot snapshot = await db.collection('counselor').doc(documentId).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      data['holyDate'] = data['holyDate'];
      data['date'] = data['date'];
      data['possibleTime'] = data['possibleTime'];
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

  Future<List<ReservationList>> getReservationList(String counseloId) async {
    List<ReservationList> reservationList = [];
    try {
      QuerySnapshot snapshot = await db.collection('reservaion').where('conselorId', isEqualTo: counseloId).get();
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


  // TODO : 예약 디비 수정해야함.
  Future<void> addReservation(String documentId, ReservationList reservationList, DateTime date) async {
    try {
      Map<String, dynamic> data = reservationList.toJson();
      if(await checkReservation(documentId, date)) {
        await db.collection('counselor').doc(documentId).update({
          'reservationList': FieldValue.arrayUnion([reservationList.toJson()])
        });
        await db.collection('reservaion').add(data);
      }
    } catch (e) {
      print('예약 추가할때 걸림');
      print(e);
    }
  }
}