import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/model/reservation.dart';

class ReservationController extends GetxController {
  List<Reservation> reservationList = [];

  List<Color> exColor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.white,
    Colors.black,
    Colors.grey
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}