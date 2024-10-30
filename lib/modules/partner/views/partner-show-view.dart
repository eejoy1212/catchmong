import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/alert-btn.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';

class PartnerShowView extends StatelessWidget {
  const PartnerShowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/left-arrow.png'),
        actions: [
          Image.asset('assets/images/upload-icon.png'),
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
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
                bottom: 12,
              ),
              padding: EdgeInsets.only(
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
          ],
        ),
      ),
    );
  }
}
