import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarBackBtn extends StatelessWidget {
  final void Function()? onTap;
  const AppbarBackBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(); // onTap이 전달된 경우 실행
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
          });
        }
      },
      child: Image.asset(
        'assets/images/left-arrow.png',
        width: 24, // 적절한 크기로 설정
        height: 24, // 적절한 크기로 설정
      ),
    );
  }
}
