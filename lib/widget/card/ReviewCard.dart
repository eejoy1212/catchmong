import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/chip/TagChip.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240, // 카드의 너비
      // height: 412, // 카드의 높이
      margin: const EdgeInsets.only(
          right: 16, top: 12, bottom: 12), // 카드 간의 간격을 위해 오른쪽 마진 설정
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A의 그림자 (투명한 검정)
            offset: Offset(0, 4), // x축 0, y축 4로 그림자 위치 설정
            blurRadius: 12, // 흐림 효과 (blur)
          ),
        ],
        borderRadius: BorderRadius.circular(12), // 둥근 모서리 반지름 12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 아바타 이미지
                ClipOval(
                  child: Container(
                    width: 36, // 아바타 너비 36px
                    height: 36, // 아바타 높이 36px
                    child: Image.asset(
                      'assets/images/profile1.jpg',
                      fit: BoxFit.cover, // 이미지가 원형 안에 잘 맞도록 설정
                    ),
                  ),
                ),
                SizedBox(width: 8), // 아바타와 텍스트 사이의 간격
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "사용자 이름",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CatchmongColors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "작성일",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_300),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "24.10.11",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_300),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 여기에 프로필 이미지 경로로 이미지를 넣음
          Stack(children: [
            Container(
              height: 240,
              width: double.infinity,
              child: Image.asset(
                'assets/images/review1.jpg', // 이미지 경로
                fit: BoxFit.cover, // 이미지가 영역에 맞게 출력되도록 설정
              ),
            ),
            Positioned(
              left: 20,
              bottom: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/thumbs-up.png"),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "타이틀을 작성해주세요",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "리뷰 내용을 작성해주세요",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "가게명",
                      style: TextStyle(
                          color: CatchmongColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/review-star.png'),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '5.0',
                          style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '(1,000)',
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                Image.asset('assets/images/pin.png')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                TagChip(label: "#다이닝바"),
                SizedBox(
                  width: 4,
                ),
                TagChip(label: "#논현"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
