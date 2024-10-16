import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarBackBtn extends StatelessWidget {
  const AppbarBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        'assets/images/left-arrow.png',
        width: 24, // 적절한 크기로 설정
        height: 24, // 적절한 크기로 설정
      ),
    );
  }
}
