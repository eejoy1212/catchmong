import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:catchmong/widget/card/ReviewCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HotTypeCard extends StatelessWidget {
  const HotTypeCard({
    super.key,
  });
  static const int itemsPerPage = 8; // 한 페이지에 보여줄 항목 수
  static const int totalItems = 16;
  @override
  Widget build(BuildContext context) {
    final totalPages = (totalItems / itemsPerPage).ceil(); // 총 페이지 수 계산
    final Partner2Controller partner2Controller =
        Get.find<Partner2Controller>();
    return MainCard(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "요즘 이런 식당이 HOT 해!",
                  style: TextStyle(
                      color: CatchmongColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Obx(() => Container(
                      decoration: BoxDecoration(
                        color: CatchmongColors.yellow_main,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 32,
                      height: 20,
                      child: Center(
                          child: Text(
                        "${partner2Controller.currentHotPage.value + 1}/${(totalItems / itemsPerPage).ceil()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 160, // 두 줄의 높이에 맞춰 설정
              child: PageView.builder(
                itemCount: totalPages,
                controller: PageController(
                  viewportFraction: 1.0, // 전체 페이지 너비 사용
                ),
                onPageChanged: (value) {
                  partner2Controller.currentResPage.value = value;
                },
                itemBuilder: (context, pageIndex) {
                  // 페이지의 시작과 끝 인덱스 계산
                  final startIndex = pageIndex * itemsPerPage;
                  final endIndex =
                      (startIndex + itemsPerPage).clamp(0, totalItems);

                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(), // 내부 스크롤 방지
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 한 줄에 4개
                      mainAxisSpacing: 8, // 세로 간격
                      crossAxisSpacing: 8, // 가로 간격
                      childAspectRatio: 1, // 정사각형 비율
                    ),
                    itemCount: endIndex - startIndex,
                    itemBuilder: (context, index) {
                      final actualIndex = startIndex + index;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/${getImageForIndex(actualIndex)}',
                            width: 40, // 아이콘 크기
                            height: 40,
                          ),
                          SizedBox(height: 4),
                          Text(
                            getTitleForIndex(actualIndex),
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  );
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
      return 'date-hot.svg';
    case 1:
      return 'tv-hot.svg';
    case 2:
      return 'family-hot.svg';
    case 3:
      return 'only-hot.svg';
    case 4:
      return 'tent-hot.svg';
    case 5:
      return 'insta-hot.svg';
    case 6:
      return 'room-hot.svg';
    case 7:
      return 'cheap-hot.svg';
    case 8:
      return 'openrun-hot.svg';
    case 9:
      return 'kids-hot.svg';
    case 10:
      return 'michelin-hot.svg';
    case 11:
      return 'mood-hot.svg';
    case 12:
      return 'view-hot.svg';
    case 13:
      return 'brunch-hot.svg';
    case 14:
      return 'hide-hot.svg';
    case 15:
      return 'new-hot.svg';
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
      return '파티룸';
    case 7:
      return '가성비맛집';
    case 8:
      return '오픈런맛집';
    case 9:
      return '키즈존';
    case 10:
      return '미슐랭';
    case 11:
      return '분위기있는';
    case 12:
      return '야경이있는';
    case 13:
      return '브런치맛집';
    case 14:
      return '숨은맛집';
    case 15:
      return '이색테마';

    default:
      return ''; // 인덱스가 0-8 외의 값일 경우 빈 문자열 반환
  }
}
