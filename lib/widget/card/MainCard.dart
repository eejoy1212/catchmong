import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double minWidth;

  MainCard(
      {required this.child, this.minWidth = 0}); // 최소 너비를 매개변수로 받아 기본값은 0으로 설정

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // 좌우 여백을 20픽셀로 설정
      constraints: BoxConstraints(
        minWidth: minWidth, // 최소 너비를 설정
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000), // #0000000D의 색상 (투명한 검정)
            offset: Offset(0, 2), // x축 0, y축 2로 그림자 위치 설정
            blurRadius: 8, // 흐림 효과 (blur)
          ),
        ],
        border: Border.all(
          color: Color(0xFFEFEFEF), // #efefef 테두리 색상
          width: 1, // 테두리 두께
        ),
        borderRadius: BorderRadius.circular(8), // 둥근 모서리 반지름 8
      ),
      child: child, // 카드 안에 표시될 내용을 child로 받음
    );
  }
}
