import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class BorderTxtarea extends StatelessWidget {
  final String? hintText;
  final double width;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool? readOnly;
  const BorderTxtarea(
      {super.key,
      this.hintText,
      this.readOnly = false,
      required this.width,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // 좌우 여백 20씩 추가
      height: 200, // 고정 높이 설정
      padding: EdgeInsets.symmetric(horizontal: 16), // 내부 패딩
      decoration: BoxDecoration(
        color: Colors.white, // 배경색
        borderRadius: BorderRadius.circular(8), // 테두리 둥글게
        border: Border.all(
          color: CatchmongColors.gray100, // 테두리 색상
        ),
      ),
      child: TextField(
        readOnly: readOnly ?? false,
        controller: controller,
        onChanged: onChanged,
        maxLines: null, // 여러 줄 허용
        expands: true, // TextField가 Container에 꽉 차도록 설정
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, // 기본 border 제거
        ),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: CatchmongColors.gray400,
        ), // 텍스트 스타일 설정
      ),
    );
  }
}
