import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class BorderTxtField extends StatelessWidget {
  final String text;

  const BorderTxtField({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: text, // 힌트 텍스트
        contentPadding:
            EdgeInsets.symmetric(vertical: 14, horizontal: 16), // 패딩 설정
        filled: true,
        fillColor: Colors.white, // 배경색
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 둥근 모서리 설정
          borderSide: BorderSide(
            color: CatchmongColors.gray100, // 테두리 색상
            width: 1.0, // 테두리 두께
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.gray100,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.yellow_line, // 포커스 시 테두리 색상
            width: 1.0,
          ),
        ),
      ),
      style: TextStyle(
        fontSize: 14,
        color: CatchmongColors.gray_800,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
