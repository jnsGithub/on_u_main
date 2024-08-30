import 'package:get/get.dart';
import 'package:on_u/model/reservation.dart';

class ChatListController extends GetxController {
  late List<Reservation> counselorList;

  @override
  void onInit() {
    super.onInit();
    counselorList = Get.arguments;
  }
  @override
  void onClose(){
    super.onClose();
  }
}