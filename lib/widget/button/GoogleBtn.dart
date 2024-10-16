import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // 로딩 다이얼로그 표시
        Get.dialog(
          Center(child: CircularProgressIndicator()),
          barrierDismissible: false, // 다이얼로그 바깥을 눌러도 닫히지 않도록 설정
        );
        // 라우팅 수행
        await Get.toNamed('/location');

        // 라우팅 후 로딩 다이얼로그 닫기
        Get.back();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/google.png',
            width: 52, // 적절한 크기로 설정
            height: 52, // 적절한 크기로 설정
          ),
          SizedBox(height: 8), // 텍스트와 이미지 사이의 간격
          Text(
            '구글로\n시작하기',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
