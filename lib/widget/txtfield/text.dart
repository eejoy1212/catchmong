import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class TestBorderTxtField extends StatelessWidget {
  final String? hintText; // 힌트 텍스트
  final TextEditingController controller; // 컨트롤러 추가
  // final String value;
  final void Function(String) onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  const TestBorderTxtField({
    Key? key,
    this.hintText,
    // required this.value,
    required this.controller,
    required this.onChanged,
    this.textInputType,
    this.maxLength, // 생성자에서 컨트롤러 받기
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController를 동적으로 생성 및 업데이트

    return TextField(
      maxLength: maxLength,

      keyboardType: textInputType,
      controller: controller, // 텍스트 컨트롤러 연결
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.gray100,
            width: 1.0,
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
            color: CatchmongColors.yellow_line,
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
