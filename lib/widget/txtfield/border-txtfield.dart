import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class BorderTxtField extends StatelessWidget {
  final String? hintText; // 힌트 텍스트
  final TextEditingController controller; // 컨트롤러 추가
  final void Function(String) onChanged; // 텍스트 변경 콜백
  final TextInputType? textInputType;
  final int? maxLength;
  final String? errorText; // 에러 메시지
  final bool? readOnly;
  final Widget? suffix;
  final Widget? helper;
  final int? maxLines;
  final bool expands; // 텍스트 필드 확장 여부
  const BorderTxtField({
    Key? key,
    this.hintText,
    required this.controller,
    required this.onChanged,
    this.textInputType,
    this.maxLength,
    this.errorText,
    this.readOnly = false,
    this.suffix,
    this.helper,
    this.maxLines = 1, // 에러 메시지 추가
    this.expands = false, // 텍스트 필드 확장 여부
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      maxLines: maxLines,
      expands: expands,
      keyboardType: textInputType,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText, // 에러 메시지 설정
        errorStyle: TextStyle(
          color: CatchmongColors.red, // 에러 메시지 색상
          fontSize: 12, // 에러 메시지 크기 조정
          height: 1.0, // 에러 메시지 줄 간격 조정 (패딩 제거 효과)
        ),
        helper: helper,
        contentPadding: EdgeInsets.symmetric(
            vertical: 14, horizontal: 8), // 텍스트 필드 안의 텍스트 패딩
        filled: true,
        fillColor: Colors.white,
        suffix: suffix,
        suffixIcon: errorText != null
            ? Icon(
                Icons.error_outline, // 에러 아이콘
                color: CatchmongColors.red, // 에러 아이콘 색상
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.yellow_line, // 포커스 시 보더 색상
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.red, // 에러 보더 색상
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CatchmongColors.red, // 에러 상태에서 포커스 시 보더 색상
            width: 1.0,
          ),
        ),
      ),
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
