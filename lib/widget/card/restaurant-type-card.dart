import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RestaurantTypeCard extends StatelessWidget {
  const RestaurantTypeCard({
    super.key,
  });

  static const int itemsPerPage = 8; // 한 페이지에 보여줄 항목 수
  static const int totalItems = 16; // 총 항목 수

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalItems / itemsPerPage).ceil(); // 총 페이지 수 계산
    final Partner2Controller partner2Controller =
        Get.find<Partner2Controller>();
    return MainCard(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "어떤 식당을 찾으시나요?",
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
                        "${partner2Controller.currentResPage.value + 1}/${(totalItems / itemsPerPage).ceil()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ))
              ],
            ),
            SizedBox(height: 16),
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
      return 'beef-type.svg';
    case 1:
      return 'soup-type.svg';
    case 2:
      return 'izakaya-type.svg';
    case 3:
      return 'bossam-type.svg';
    case 4:
      return 'restaurant-type.svg';
    case 5:
      return 'vegan-type.svg';
    case 6:
      return 'fast-type.svg';
    case 7:
      return 'susi-type.svg';
    case 8:
      return 'pizza-type.svg';
    case 9:
      return 'chicken-type.svg';
    case 10:
      return 'kor-type.svg';
    case 11:
      return 'ramen-type.svg';
    case 12:
      return 'chinese-type.svg';
    case 13:
      return 'tbokki-type.svg';
    case 14:
      return 'dessert-type.svg';
    case 15:
      return 'buffet-type.svg';
    default:
      return '';
  }
}

String getTitleForIndex(int index) {
  switch (index) {
    case 0:
      return '고깃집';
    case 1:
      return '찌개전문';
    case 2:
      return '이자카야';
    case 3:
      return '족발/보쌈';
    case 4:
      return '레스토랑';
    case 5:
      return '비건식당';
    case 6:
      return '패스트푸드';
    case 7:
      return '회/스시';
    case 8:
      return '전집';
    case 9:
      return '치킨';
    case 10:
      return '한정식';
    case 11:
      return '라멘';
    case 12:
      return '중식';
    case 13:
      return '분식';
    case 14:
      return '디저트카페';
    case 15:
      return '뷔페';
    default:
      return '';
  }
}
