import 'package:flutter/material.dart';

class MapSearchbar extends StatelessWidget {
  const MapSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색 설정
        borderRadius: BorderRadius.circular(8.0), // 모서리 둥글게 설정
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey, // 아이콘 색상 설정
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '지역, 매장명을 검색해 주세요.',
                border: InputBorder.none, // 입력창의 기본 테두리 제거
                hintStyle: TextStyle(
                  color: Colors.grey, // 힌트 텍스트 색상 설정
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
