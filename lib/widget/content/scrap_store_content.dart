import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:flutter/material.dart';

class ScrapStoreContent extends StatelessWidget {
  const ScrapStoreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // 스크롤 가능한 리스트뷰로 변경
          child: ListView.builder(
            // padding: EdgeInsets.only(top: 16),
            itemCount: 20, // 가게 리스트의 항목 수 (예시로 20개)
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //이미지
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8), // 둥근 모서리로 잘라줌
                        child: Container(
                          width: 150,
                          height: 181,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CatchmongColors.gray,
                                width: 1), // 외부 테두리
                          ),
                          child: Image.asset(
                            'assets/images/review3.jpg', // 이미지 경로
                            fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      //설명
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "가게명",
                            style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "상품명을 입력해주세요.",
                            style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                "50%",
                                style: TextStyle(
                                  color: CatchmongColors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "77,777",
                                style: TextStyle(
                                  color: CatchmongColors.gray_800,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "원",
                                style: TextStyle(
                                  color: CatchmongColors.gray_800,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
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
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          OutlinedBtn(
                            width: 202,
                            title: '구매하기',
                          )
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
