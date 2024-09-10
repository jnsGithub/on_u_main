import 'package:get/get.dart';
import 'package:on_u/model/myReservaion.dart';
import 'package:on_u/model/reservation.dart';

class ReservationListController extends GetxController {
  late List<Reservation> counselorList;
  List<MyReservation> myReservationList = [];

  @override
  void onInit() async{
    super.onInit();
    counselorList = Get.arguments;
    await init();
  }

  @override
  void onClose() {
    super.onClose();
  }
  init() async{
    myReservationList.add(MyReservation(documentId: 'gdg', counselor: '홍길동', counselorInfo: '상담 요청 전화번호 010-1234-5678', date: DateTime.now(), myName: '김철수', hp: '010-1234-5678', request: '상담 요청 내용'));
    myReservationList.add(MyReservation(documentId: 'gdg', counselor: '김철수', counselorInfo: '상담 요청 전화번호 010-1234-5678', date: DateTime.now(), myName: '김철수', hp: '010-1234-5678', request: '상담 요청 내용'));
    myReservationList.add(MyReservation(documentId: 'gdg', counselor: '이영희', counselorInfo: '상담 요청 전화번호 010-1234-5678', date: DateTime.now(), myName: '김철수', hp: '010-1234-5678', request: '상담 요청 내용'));
    myReservationList.add(MyReservation(documentId: 'gdg', counselor: '김철수', counselorInfo: '상담 요청 전화번호 010-1234-5678', date: DateTime.now(), myName: '김철수', hp: '010-1234-5678', request: '상담 요청 내용'));
    myReservationList.add(MyReservation(documentId: 'gdg', counselor: '김영희', counselorInfo: '상담 요청 전화번호 010-1234-5678', date: DateTime.now(), myName: '김철수', hp: '010-1234-5678', request: '상담 요청 내용'));
  }
}