import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class KakaoBtn extends StatelessWidget {
  final void Function() onTap;

  const KakaoBtn({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/kakao.png',
            width: 52, // 적절한 크기로 설정
            height: 52, // 적절한 크기로 설정
          ),
          SizedBox(height: 8), // 텍스트와 이미지 사이의 간격
          Text(
            '카카오로\n시작하기',
            style: TextStyle(
              color: CatchmongColors.gray_800,
            ),
          ),
        ],
      ),
    );
  }
}
