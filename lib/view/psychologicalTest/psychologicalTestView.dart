import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestController.dart';

class PsychologicalTestView extends GetView<PsychologicalTestController> {
  const PsychologicalTestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PsychologicalTestController());
    return Container(
      child: Center(
        child: Text('심리테스트 화면'),
      ),
    );
  }
}
