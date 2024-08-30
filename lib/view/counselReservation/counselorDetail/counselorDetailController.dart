import 'package:get/get.dart';
import 'package:on_u/model/reservation.dart';

class CounselorDetailController extends GetxController {
  late Reservation reservation;

  @override
  void onInit() {
    super.onInit();
    reservation = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
  }
}