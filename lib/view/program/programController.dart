import 'package:get/get.dart';

import '../../model/program.dart';

class ProgramController extends GetxController {
  List<Program> programList = [];

  @override
  void onInit() {
    super.onInit();
    print(programList);
  }

  @override
  void onClose() {
    super.onClose();
  }
}