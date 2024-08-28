import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'myPageController.dart';

class MyPageView extends GetView<MyPageController> {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('마이페이지 화면'),
      ),
    );
  }
}
