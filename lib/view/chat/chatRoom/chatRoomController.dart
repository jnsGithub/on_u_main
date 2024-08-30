import 'package:get/get.dart';
import 'package:on_u/model/reservation.dart';

class ChatRoomController extends GetxController{
  late Reservation counselor;
  List<bool> a = [true, false, true, false, true, false, true, false, true, false];

  @override
  void onInit() {
    super.onInit();
    counselor = Get.arguments;
  }
  @override
  void onClose(){
    super.onClose();
  }
}