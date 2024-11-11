import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // 배경색을 검정으로, 투명도 40% 설정
      ),
      padding: EdgeInsets.all(8.0), // 텍스트와 컨테이너 사이에 여백을 추가할 수 있습니다.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              "울산광역시 울주군 삼남읍 도호1길 9-15 울산광역시 울주군 삼남읍 도호1길 9-15",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis, // 오버플로우시 말줄임표 처리
              maxLines: 1, // 한 줄로 제한
              softWrap: false, // 텍스트 줄바꿈 비활성화
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () {},
            child: Text(
              "주소검색",
              style: TextStyle(fontSize: 14, color: CatchmongColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
