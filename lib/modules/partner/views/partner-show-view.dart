import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/alert-btn.dart';
import 'package:catchmong/widget/button/location-copy-btn.dart';
import 'package:catchmong/widget/button/more-btn.dart';
import 'package:catchmong/widget/button/phone-call-btn.dart';
import 'package:catchmong/widget/card/partner-review-card.dart';
import 'package:catchmong/widget/chip/partner-content-chip.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerShowView extends StatelessWidget {
  const PartnerShowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackBtn(),
        actions: [
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                              opacity: 0,
                              child:
                                  Image.asset('assets/images/close-icon.png')),
                          Text(
                            "공유하기",
                            style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child:
                                  Image.asset('assets/images/close-icon.png'))
                        ],
                      ),
                      content: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/kakao-share.png'),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "카카오로\n공유하기",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_800,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/link-share.png'),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "링크로\n공유하기",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_800,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset('assets/images/upload-icon.png')),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //이미지 그리드
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 220,
                    height: 220,
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
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: Image.asset(
                                'assets/images/review2.jpg', // 이미지 경로
                                fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: Image.asset(
                                'assets/images/review2.jpg', // 이미지 경로
                                fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: Image.asset(
                                'assets/images/review2.jpg', // 이미지 경로
                                fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Stack(children: [
                              Container(
                                width: 108,
                                height: 108,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CatchmongColors.gray,
                                      width: 1), // 외부 테두리
                                ),
                                child: Image.asset(
                                  'assets/images/review2.jpg', // 이미지 경로
                                  fit:
                                      BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                                ),
                              ),
                              Positioned.fill(
                                  child: Center(
                                      child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/img-icon.png'),
                                      Text(
                                        "999+",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )))
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
            //정보
            //가게명
            ,
            //알림받기 컨테이너
            Container(
              margin: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "가게명",
                        style: TextStyle(
                          color: CatchmongColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      StarStatus(),
                      Spacer(),
                      //pin 뱃지
                      AlertBtn(),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset('assets/images/pin.png')
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "영업중",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      Text(
                        "한식",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      Text(
                        "리뷰 999+",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //가게소개 카드
            Container(
              margin: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //주소복사
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/marker-icon.png'),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "서울 강남구 강남대로92길 19 트레바리 강남 아지트(여원빌딩) 2층 밍글몰트",
                          softWrap: true, // 텍스트 줄바꿈 설정
                          overflow: TextOverflow.ellipsis, // 넘치는 텍스트를 잘라내기 설정
                          maxLines: 3, // 최대 줄 수 설정 (필요 시)
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      LocationCopyBtn()
                    ],
                  )
                  //전화번호
                  ,
                  SizedBox(
                    height: 12,
                  ),
                  PhoneCallBtn(),
                  SizedBox(
                    height: 12,
                  ),
                  //시간
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/clock-icon.png'),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "월 휴무",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "화 - 토 오후 6:30 - 오전 1:00",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "일 오후 6:30 - 오후 11:00",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                  //가게소개문구
                  ,
                  SizedBox(
                    height: 12,
                  ),
                  //가게 소개 문구
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/heart-icon.png'),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "가게 소개 문구 작성해주세요.",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PartnerContentChip(
                                title: "아기의자",
                                image:
                                    Image.asset('assets/images/baby-icon.png'),
                              ),
                              PartnerContentChip(
                                title: "쿠폰",
                                image: Image.asset(
                                    'assets/images/coupon-icon.png'),
                              ),
                              PartnerContentChip(
                                title: "주차",
                                image: Image.asset(
                                    'assets/images/parking-icon.png'),
                              ),
                              PartnerContentChip(
                                title: "애견동반",
                                image:
                                    Image.asset('assets/images/pet-icon.png'),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                  //리뷰 카드
                  ,
                ],
              ),
            ),
            Column(
              children: List.generate(10, (index) => PartnerReviewCard()),
            ),
          ],
        ),
      ),
    );
  }
}
