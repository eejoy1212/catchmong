import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/content/payback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PaybackContent extends StatelessWidget {
  final PaybackController controller = Get.find<PaybackController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //프로필
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36, // 동그라미의 너비
                    height: 36, // 동그라미의 높이
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: CatchmongColors.gray, // 동그라미 색상
                      shape: BoxShape.circle, // 동그라미 모양
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "이원희님",
                        style: TextStyle(
                          color: CatchmongColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "계정 아이디",
                        style: TextStyle(
                          color: CatchmongColors.gray_300,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 20,
                        decoration: BoxDecoration(
                          color: CatchmongColors.yellow_main,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "내 계좌",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "신한 110-123-456789 예금주명",
                        style: TextStyle(
                            color: CatchmongColors.gray_300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: CatchmongColors.gray_300,
                        size: 14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              //페이 카드
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CatchmongColors.yellow_main,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/logo-icon.svg'),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "캐치페이",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "0원",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: YellowElevationBtn(
                                bgColor: Colors.white,
                                onPressed: () {},
                                title: Text(
                                  "이용내역",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ))),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: YellowElevationBtn(
                                bgColor: Colors.white,
                                onPressed: () {},
                                title: Text(
                                  "계좌송금",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                )))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ), //누적 페이백 카드
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CatchmongColors.gray50,
                  ),
                  color: Colors.white, // 컨테이너 배경색
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D000000), // #0000000D (10% 투명도)
                      blurRadius: 8, // 흐림 효과 반경
                      offset: Offset(0, 2), // 그림자의 X, Y 축 이동
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "내 누적 페이백",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SvgPicture.asset("assets/images/question-circle.svg"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 내 페이백
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/dollar.svg"),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "내 페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "24.12.19",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "+3,000원",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        )
                        // 내 추천인
                        ,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/dollar.svg"),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "내 추천인",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "24.12.19",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "+3,000원",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ), // 자식 위젯
              ),
              SizedBox(
                height: 20,
              ),
              //내 페이백 내역 카드
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CatchmongColors.gray50,
                  ),
                  color: Colors.white, // 컨테이너 배경색
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D000000), // #0000000D (10% 투명도)
                      blurRadius: 8, // 흐림 효과 반경
                      offset: Offset(0, 2), // 그림자의 X, Y 축 이동
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "내 페이백",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: CatchmongColors.sub_gray,
                          size: 14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 내 페이백
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36, // 동그라미의 너비
                              height: 36, // 동그라미의 높이
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: CatchmongColors.gray, // 동그라미 색상
                                shape: BoxShape.circle, // 동그라미 모양
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "이원희님",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "24.12.19",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "+3,000원",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36, // 동그라미의 너비
                              height: 36, // 동그라미의 높이
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: CatchmongColors.gray, // 동그라미 색상
                                shape: BoxShape.circle, // 동그라미 모양
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "이원희님",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "24.12.19",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "+3,000원",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36, // 동그라미의 너비
                              height: 36, // 동그라미의 높이
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: CatchmongColors.gray, // 동그라미 색상
                                shape: BoxShape.circle, // 동그라미 모양
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "이원희님",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "24.12.19",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "+3,000원",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "페이백",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 12,
                        )
                        // 내 추천인
                        ,
                      ],
                    )
                  ],
                ), // 자식 위젯
              ),
              SizedBox(
                height: 20,
              ),
              //마이 추천 파트너 스토어
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CatchmongColors.gray50,
                  ),
                  color: Colors.white, // 컨테이너 배경색
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D000000), // #0000000D (10% 투명도)
                      blurRadius: 8, // 흐림 효과 반경
                      offset: Offset(0, 2), // 그림자의 X, Y 축 이동
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MY 추천 파트너",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SvgPicture.asset("assets/images/question-circle.svg"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 내 페이백
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3 회",
                                  style: TextStyle(
                                    color: CatchmongColors.yellow_main,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "최애파트너",
                                  style: TextStyle(
                                    color: CatchmongColors.sub_gray,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            Container(
                              width: 48, // 동그라미의 너비
                              height: 48, // 동그라미의 높이
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: CatchmongColors.gray, // 동그라미 색상
                                borderRadius:
                                    BorderRadius.circular(16), // 동그라미 모양
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ), // 자식 위젯
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
