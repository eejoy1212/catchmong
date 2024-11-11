import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:catchmong/widget/card/ReviewCard.dart';
import 'package:flutter/material.dart';

class RestaurantTypeCard extends StatelessWidget {
  const RestaurantTypeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "어떤 식당을 찾으시나요?",
              style: TextStyle(
                  color: CatchmongColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 74, // 카드의 높이와 동일하게 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                itemCount: 9, // 카드의 개수
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    margin: EdgeInsets.only(
                      right: 4,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/${getImageForIndex(index)}'),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          getTitleForIndex(index),
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ); // ReviewCard를 리스트에 삽입
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getImageForIndex(int index) {
  switch (index) {
    case 0:
      return 'korea-type.png';
    case 1:
      return 'chinese-type.png';
    case 2:
      return 'japan-type.png';
    case 3:
      return 'american-type.png';
    case 4:
      return 'tbokki-type.png';
    case 5:
      return 'fast-type.png';
    case 6:
      return 'vegan-type.png';
    case 7:
      return 'desert-type.png';
    case 8:
      return 'buffet-type.png';
    default:
      return ''; // 인덱스가 0-8 외의 값일 경우 빈 문자열 반환
  }
}

String getTitleForIndex(int index) {
  switch (index) {
    case 0:
      return '한식';
    case 1:
      return '중식';
    case 2:
      return '일식';
    case 3:
      return '양식';
    case 4:
      return '분식';
    case 5:
      return '패스트푸드';
    case 6:
      return '비건식당';
    case 7:
      return '디저트카페';
    case 8:
      return '뷔페';
    default:
      return ''; // 인덱스가 0-8 외의 값일 경우 빈 문자열 반환
  }
}
