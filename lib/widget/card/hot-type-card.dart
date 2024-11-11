import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:catchmong/widget/card/ReviewCard.dart';
import 'package:flutter/material.dart';

class HotTypeCard extends StatelessWidget {
  const HotTypeCard({
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
              "요즘 이런 식당이 HOT 해!",
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
                itemCount: 10, // 카드의 개수
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
      return 'date-hot.png';
    case 1:
      return 'tv-hot.png';
    case 2:
      return 'family-hot.png';
    case 3:
      return 'only-hot.png';
    case 4:
      return 'tent-hot.png';
    case 5:
      return 'insta-hot.png';
    case 6:
      return 'room-hot.png';
    case 7:
      return 'cheap-hot.png';
    case 8:
      return 'restaurant-hot.png';
    case 9:
      return 'michelin-hot.png';
    default:
      return ''; // 인덱스가 0-8 외의 값일 경우 빈 문자열 반환
  }
}

String getTitleForIndex(int index) {
  switch (index) {
    case 0:
      return '데이트맛집';
    case 1:
      return '화제의예능';
    case 2:
      return '가족모임';
    case 3:
      return '혼밥';
    case 4:
      return '노포';
    case 5:
      return '인스타핫플';
    case 6:
      return '룸이있는';
    case 7:
      return '가성비맛집';
    case 8:
      return '레스토랑';
    case 9:
      return '미슐랭';
    default:
      return ''; // 인덱스가 0-8 외의 값일 경우 빈 문자열 반환
  }
}
