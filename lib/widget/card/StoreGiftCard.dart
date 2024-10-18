import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class StoreGiftCard extends StatelessWidget {
  const StoreGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 249,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // 둥근 모서리로 잘라줌
              child: Container(
                width: 176,
                height: 175,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: CatchmongColors.gray, width: 1), // 외부 테두리
                ),
                child: Image.asset(
                  'assets/images/review2.jpg', // 이미지 경로
                  fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset('assets/images/event-price-chip.png')),
            Positioned(
                bottom: 8,
                right: 8,
                child: Image.asset('assets/images/partner-chip.png')),
          ]),
          SizedBox(
            height: 8,
          ),
          Text(
            "상품명을 입력해주세요.",
            style: TextStyle(
              color: CatchmongColors.gray_800,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Text(
                "50%",
                style: TextStyle(
                    color: CatchmongColors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "23,333",
                style: TextStyle(
                    color: CatchmongColors.gray_800,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "원",
                style: TextStyle(
                    color: CatchmongColors.gray_800,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              )
            ],
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
    );
  }
}
