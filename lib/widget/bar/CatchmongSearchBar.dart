import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class CatchmongSearchBar extends StatelessWidget {
  final String searchKeyword;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmitted;
  const CatchmongSearchBar(
      {super.key,
      required this.searchKeyword,
      required this.onSubmitted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // 높이를 48px로 설정
      decoration: BoxDecoration(
        color: CatchmongColors.gray50, // 배경색 #efefef`
        borderRadius: BorderRadius.circular(8), // borderRadius 8px
      ),
      child: TextField(
        controller:
            TextEditingController(text: searchKeyword), // 텍스트 필드에 컨트롤러 연결
        onChanged: onChanged,

        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: '가게이름을 검색해보세요', // 텍스트 필드에 힌트 넣기 (선택 사항)
          prefixIcon:
              Image.asset('assets/images/searchbar-icon.png'), // 돋보기 아이콘 추가
          border: InputBorder.none, // 기본 보더 제거
          contentPadding: const EdgeInsets.symmetric(vertical: 14), // 텍스트 수직 정렬
        ),
      ),
    );
  }
}
