import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class CatchmongSearchBar extends StatelessWidget {
  const CatchmongSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // 높이를 48px로 설정
      decoration: BoxDecoration(
        color: CatchmongColors.gray50, // 배경색 #efefef`
        borderRadius: BorderRadius.circular(8), // borderRadius 8px
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '상품을 검색해보세요', // 텍스트 필드에 힌트 넣기 (선택 사항)
          prefixIcon:
              Image.asset('assets/images/searchbar-icon.png'), // 돋보기 아이콘 추가
          border: InputBorder.none, // 기본 보더 제거
          contentPadding: const EdgeInsets.symmetric(vertical: 14), // 텍스트 수직 정렬
        ),
      ),
    );
  }
}
