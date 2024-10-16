import 'package:flutter/material.dart';

class NaverBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('네이버 버튼 클릭');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/naver.png',
            width: 52, // 적절한 크기로 설정
            height: 52, // 적절한 크기로 설정
          ),
          SizedBox(height: 8), // 텍스트와 이미지 사이의 간격
          Text('네이버로\n시작하기'),
        ],
      ),
    );
  }
}
