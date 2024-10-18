import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:catchmong/widget/card/ReviewCard.dart';
import 'package:catchmong/widget/card/StoreGiftCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16, bottom: 16),
          child: Row(
            children: [
              Text(
                '모든지역',
                style: TextStyle(
                    color: CatchmongColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Image.asset('assets/images/right-arrow.png')
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 260,
              color: CatchmongColors.gray,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Image.asset('assets/images/partner.png')),
                        Expanded(child: Image.asset('assets/images/store.png')),
                        Expanded(
                            child: Image.asset('assets/images/payback.png')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 리뷰몽
            MainCard(
              minWidth: 320,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "인기 맛집 리뷰몽",
                      style: TextStyle(
                          color: CatchmongColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "직접 먹어 봤어요! 리얼 리뷰!",
                      style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 436, // 카드의 높이와 동일하게 설정
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                        itemCount: 5, // 카드의 개수
                        itemBuilder: (context, index) {
                          return ReviewCard(); // ReviewCard를 리스트에 삽입
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            //스토어
            MainCard(
              minWidth: 320,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "스토어 상품",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "구매하고 페이백 받아 보세요!",
                              style: TextStyle(
                                  color: CatchmongColors.sub_gray,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print("더보기");
                          },
                          child: Text(
                            "더보기",
                            style: TextStyle(
                                color: CatchmongColors.gray400,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 550,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 한 줄에 두 개의 아이템을 배치
                          mainAxisSpacing: 20, // 세로 간격
                          crossAxisSpacing: 16, // 가로 간격
                          childAspectRatio:
                              0.6, // 카드의 가로세로 비율 조정 (카드의 높이를 늘리기 위해 비율 설정)
                        ),
                        itemCount: 4, // 카드의 개수
                        itemBuilder: (context, index) {
                          return StoreGiftCard(); // 각 그리드 셀에 들어갈 카드 컴포넌트
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 120, // 카드의 높이와 동일하게 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                itemCount: 2, // 카드의 개수
                itemBuilder: (context, index) {
                  return Image.asset(
                      "assets/images/banner${index + 1}.png"); // ReviewCard를 리스트에 삽입
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
