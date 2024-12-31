import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/modules/mypage/views/mypage_setting.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:catchmong/widget/bar/close_appbar.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/bar/preview_appbar.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/partner-review-card.dart';
import 'package:catchmong/widget/card/reservation_status_card.dart';
import 'package:catchmong/widget/chart/horizontal_stacked_bar_chart.dart';
import 'package:catchmong/widget/chart/half_pie_chart.dart';
import 'package:catchmong/widget/dialog/UseDialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyPageView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  final MypageController myPageController = Get.find<MypageController>();

  @override
  Widget build(BuildContext context) {
    bool isLogin = loginController.user.value != null;
    print("in mypage user>>>${loginController.user} // $isLogin ");
    final String baseUrl = 'http://192.168.200.102:3000';
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          //내 정보 구간
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: CatchmongColors.gray50,
            ))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //프로필
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                          width: 36, // 아바타 너비 36px
                          height: 36, // 아바타 높이 36px
                          child: loginController.user.value?.picture == null
                              ? Image.asset(
                                  'assets/images/default-profile.png',
                                  fit: BoxFit.cover,
                                )
                              : ImgCard(
                                  path:
                                      '${loginController.baseUrl}${loginController.user.value?.picture}')),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${loginController.user.value?.nickname}님",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          loginController.user.value?.email ?? "",
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 16,
                ),
                //친추 페이백 버튼
                InkWell(
                  onTap: () {
                    showShareDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                        color: CatchmongColors.yellow_main,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: CatchmongColors.yellow_line,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "친구 초대하고 1%페이백 받기",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                ),
                //추천인, 추천인 목록 버튼들
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    //추천인 버튼
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            if (myPageController.myPageToggle.value == 0) {
                              myPageController.myPageToggle.value = 1;
                            } else {
                              myPageController.myPageToggle.value = 0;
                            }
                          },
                          child: Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                    color: CatchmongColors.gray100,
                                  )),
                              child: Center(
                                child: Text(
                                  myPageController.myPageToggle.value == 0
                                      ? "내 추천인"
                                      : loginController
                                              .referrer.value?.nickname ??
                                          "없음",
                                  style: TextStyle(
                                      color: CatchmongColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          )),
                    )
                    //추천인 목록 버튼
                    ,
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showRecommenderDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: CatchmongColors.gray100,
                              )),
                          child: Center(
                            child: Text(
                              "추천인 목록",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
          //타일 1-스크랩
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/scrap');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "스크랩",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
          //타일 1-내 예약
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/scrap');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "내 예약",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )

          //타일 2-내가 쓴 글
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-write');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "내가 쓴 글",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
          //타일 3-구매 내역
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-purchase');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "구매 내역",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
//타일 3-내 가게
          ,
          InkWell(
            onTap: () {
              showMyStore(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "내 가게",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
//타일 3-고객센터
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-purchase');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "고객센터",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )

          //타일 4-서비스 이용약관
          ,
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UseDialog();
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "서비스 이용약관",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          ) //타일 5-개인정보 처리방침
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "개인정보 처리방침",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          ) //타일 6-위치정보 이용약관
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "위치정보 이용약관",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

//추천인 창
void showRecommenderDialog(BuildContext context) {
  final LoginController loginController = Get.find<LoginController>();
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
                opacity: 0, child: Image.asset('assets/images/close-icon.png')),
            Text(
              "추천인 목록",
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
                child: Image.asset('assets/images/close-icon.png'))
          ],
        ),
        content: SizedBox(
          height: 350,
          child: ListView.builder(
            itemCount: loginController.referreds.length, // 원하는 데이터 개수로 설정
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 36, // 아바타 너비 36px
                        height: 36, // 아바타 높이 36px
                        child: loginController.user.value?.picture == null ||
                                loginController.referreds[index].picture == null
                            ? Image.asset(
                                'assets/images/default-profile.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${loginController.baseUrl}${loginController.referreds[index].picture}',
                                fit: BoxFit.cover, // 이미지가 원형 안에 잘 맞도록 설정
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${loginController.referreds[index].nickname}님",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${loginController.referreds[index].email}",
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

//공유하기 창
void showShareDialog(BuildContext context) {
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
                opacity: 0, child: Image.asset('assets/images/close-icon.png')),
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
                child: Image.asset('assets/images/close-icon.png'))
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
              InkWell(
                onTap: () {
                  // 클립보드에 "공유링크" 텍스트 복사
                  Clipboard.setData(ClipboardData(text: "공유링크"));
                  Get.back();
                  showShareConfirmDialog(context);
                },
                child: Column(
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
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void showStoreInfo(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  Color color = Color(0xFFFFCFCF);
  Color color2 = Color(0xFFFF6161);
  final data = [
    [30, 70], // 10대
    [50, 50], // 20대
    [20, 80], // 30대
    [40, 60], // 40대
    [60, 40], // 50대
    [70, 30], // 60대
    [10, 90], // 70대
  ];

  final labels = ["10대", "20대", "30대", "40대", "50대", "60대", "70대 이상"];
  final colors = [
    CatchmongColors.blue1,
    Color(0xFFF98585),
  ];
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "닫기",
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: CatchmongColors.gray50,
        appBar: DefaultAppbar(title: "호박꽃마차 대전점"),
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                        color: CatchmongColors.gray50,
                      ))),
                  child: TabBar(
                    labelColor: CatchmongColors.black,
                    indicatorColor: CatchmongColors.black,
                    tabs: [
                      Tab(text: "통계"),
                      Tab(text: "예약"),
                      Tab(text: "리뷰"),
                      Tab(text: "설정"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // 통계 탭
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //날짜 선택 섹션
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                child: Row(
                                  children: [
                                    //날짜 드롭박스
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      height: 48,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: "직접선택",
                                        items: [
                                          "년간",
                                          "월간",
                                          "주간",
                                          "일간",
                                          "직접선택",
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {}
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //연도
                                    Expanded(
                                      child: OutlinedBtn(
                                          height: 48,
                                          title: "2024",
                                          onPress: () {}),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //조회수 섹션
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "조회수",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/info.svg')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: BarChart(
                                          BarChartData(
                                            alignment:
                                                BarChartAlignment.spaceAround,
                                            maxY: 10,
                                            titlesData: FlTitlesData(
                                              leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  interval: 2,
                                                  getTitlesWidget:
                                                      (value, meta) => Text(
                                                    value.toInt().toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                showTitles: false,
                                              )),
                                              rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                showTitles: false,
                                              )),
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    const days = [
                                                      '일',
                                                      '월',
                                                      '화',
                                                      '수',
                                                      '목',
                                                      '금',
                                                      '토'
                                                    ];
                                                    return Text(
                                                      days[value.toInt()],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    );
                                                  },
                                                  interval: 1,
                                                ),
                                              ),
                                            ),
                                            barGroups: [
                                              BarChartGroupData(
                                                x: 0,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 4, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 1,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 6, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 2,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 5, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 3,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 7, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 4,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 8, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 5,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 6, color: color2)
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 6,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 5, color: color2)
                                                ],
                                              ),
                                            ],
                                            gridData: FlGridData(show: false),
                                            borderData:
                                                FlBorderData(show: false),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //성별 연령 섹션
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "성별 & 연령",
                                                style: TextStyle(
                                                  color:
                                                      CatchmongColors.gray_800,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/images/info.svg')
                                            ],
                                          ),
                                          Container(
                                            // width: 130,
                                            height: 26,
                                            child: ToggleButtons(
                                              isSelected: [
                                                true,
                                                false
                                              ], // 선택 상태
                                              onPressed: (int index) {},
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              selectedColor: Colors.white,
                                              fillColor:
                                                  CatchmongColors.yellow_main,
                                              color: CatchmongColors.gray400,
                                              selectedBorderColor:
                                                  CatchmongColors.yellow_main,
                                              borderColor:
                                                  CatchmongColors.yellow_main,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0),
                                                  child: Text("온라인"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0),
                                                  child: Text("오프라인"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: 120,
                                      margin:
                                          EdgeInsets.only(left: 15, top: 28),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start, // Row의 정렬
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // 수직 중앙 정렬
                                        children: [
                                          Expanded(
                                            flex: 2, // 첫 번째 Row의 비율 (2)
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start, // Row의 정렬
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start, // 수직 중앙 정렬
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  child: Text(
                                                    "전체",
                                                    style: TextStyle(
                                                      color: CatchmongColors
                                                          .gray400,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        8), // 텍스트와 파이차트 사이 간격
                                                Container(
                                                  height: 80, // 적절한 크기 지정
                                                  width: 80, // 적절한 크기 지정
                                                  margin:
                                                      EdgeInsets.only(top: 60),
                                                  child: FittedBox(
                                                    fit: BoxFit
                                                        .contain, // 부모 컨테이너에 맞게 조정
                                                    child: SizedBox(
                                                      height:
                                                          80, // PieChart의 기본 크기를 지정
                                                      width:
                                                          80, // PieChart의 기본 크기를 지정
                                                      child: HalfPieChart(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1, // 두 번째 Row의 비율 (1)
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "58%",
                                                      style: TextStyle(
                                                        color: CatchmongColors
                                                            .gray_800,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/man-paper.svg'),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          "남자",
                                                          style: TextStyle(
                                                            color:
                                                                CatchmongColors
                                                                    .gray400,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "42%",
                                                      style: TextStyle(
                                                        color: CatchmongColors
                                                            .gray_800,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/woman-paper.svg'),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          "여자",
                                                          style: TextStyle(
                                                            color:
                                                                CatchmongColors
                                                                    .gray400,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: width,
                                        child: HorizontalStackedBarChart(
                                            data: data,
                                            labels: labels,
                                            colors: colors))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 예약 탭
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //날짜 선택 섹션
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                child: Row(
                                  children: [
                                    //날짜 드롭박스
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      height: 48,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: "일간",
                                        items: [
                                          "년간",
                                          "월간",
                                          "주간",
                                          "일간",
                                          "직접선택",
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {}
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //연도
                                    Expanded(
                                      child: OutlinedBtn(
                                          height: 48,
                                          title: "24.11.25",
                                          onPress: () {}),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //예약현황 섹션
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "예약현황",
                                                style: TextStyle(
                                                  color:
                                                      CatchmongColors.gray_800,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              SvgPicture.asset(
                                                  'assets/images/info.svg')
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: CatchmongColors
                                                              .gray),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Text(
                                                    "예약관리",
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    padding: EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: CatchmongColors
                                                              .gray),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        'assets/images/redo.svg')),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: CatchmongColors.gray),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      width: width,
                                      // height: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "1",
                                                  style: TextStyle(
                                                    color: CatchmongColors.red,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  "예약대기",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .sub_gray,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "1",
                                                  style: TextStyle(
                                                    color:
                                                        CatchmongColors.blue1,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  "예약확정",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .sub_gray,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "1",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .gray_800,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  "이용완료",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .sub_gray,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "1",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .gray_800,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  "예약취소",
                                                  style: TextStyle(
                                                    color: CatchmongColors
                                                        .sub_gray,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //예약내역 섹션
                              Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "예약내역",
                                        style: TextStyle(
                                          color: CatchmongColors.gray_800,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    // 예약상태 카드
                                    ReservationStatusCard(
                                        width: width,
                                        status: ReservationStatus
                                            .confirmed), // 예약상태 카드
                                    ReservationStatusCard(
                                        width: width,
                                        status: ReservationStatus.waiting)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 리뷰 탭
                      Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // PartnerReviewCard(
                                //   onReplyTap: () {
                                //     showReplyWrite(context);
                                //   }, review: null,
                                // ),
                                // PartnerReviewCard(
                                //   onReplyTap: () {
                                //     showReplyWrite(context);
                                //   },
                                // ),
                                // PartnerReviewCard(
                                //   onReplyTap: () {
                                //     showReplyWrite(context);
                                //   },
                                // ),
                              ],
                            ),
                          )),

                      // 설정 탭
                      Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //가게 정보 수정
                                InkWell(
                                  onTap: () {
                                    showStoreEdit(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 21,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "가게 정보 수정",
                                          style: TextStyle(
                                            color: CatchmongColors.sub_gray,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/images/right-arrow.png')
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showStoreVacationAndTime(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 21,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "임시 휴무 / 영업시간",
                                          style: TextStyle(
                                            color: CatchmongColors.sub_gray,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/images/right-arrow.png')
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showMenuAdd(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 21,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "메뉴 등록",
                                          style: TextStyle(
                                            color: CatchmongColors.sub_gray,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/images/right-arrow.png')
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showReservationSetting(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 21,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: CatchmongColors.gray50,
                                    ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "예약 설정",
                                          style: TextStyle(
                                            color: CatchmongColors.sub_gray,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/images/right-arrow.png')
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

List<PieChartSectionData> _buildPieSections() {
  return [
    PieChartSectionData(
      color: Colors.blue,
      value: 40,
      title: '40%',
      radius: 80,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 30,
      title: '30%',
      radius: 80,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 30,
      title: '30%',
      radius: 80,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];
}

void showReplyWrite(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: CatchmongColors.gray50,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ),
          child: YellowElevationBtn(
            onPressed: () {},
            title: Text("등록하기"),
          ),
        ),
        backgroundColor: CatchmongColors.gray50,
        appBar: CloseAppbar(title: "후기 작성"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 주문번호
                Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2024.10.22 08:20:00",
                        style: TextStyle(
                          color: CatchmongColors.gray400,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "주문번호 2024102212582202",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //가게명

                Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 16,
                    right: 20,
                    bottom: 32,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: CatchmongColors.gray50,
                            width: 1,
                          ), // 외부 테두리
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(8), // 이미지를 둥글게 자르기
                          child: Image.asset(
                            'assets/images/review2.jpg', // 이미지 경로
                            fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "가게명",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: CatchmongColors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "상품명을 입력해주세요.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                      20,
                                    )),
                                    border: Border.all(
                                      color: CatchmongColors.gray,
                                    )),
                                child: Center(
                                  child: Text(
                                    "수량",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: CatchmongColors.gray400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: CatchmongColors.gray400,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "1개",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: CatchmongColors.gray_800,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //상품만족도
                Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("상품은 만족하셨나요?",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/star-big.svg'),
                          SvgPicture.asset('assets/images/star-big.svg'),
                          SvgPicture.asset('assets/images/star-big.svg'),
                          SvgPicture.asset('assets/images/star-big.svg'),
                          SvgPicture.asset('assets/images/star-big-half.svg'),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "별점을 선택해주세요.",
                        style: TextStyle(
                          color: CatchmongColors.gray400,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //상품만족도
                Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("후기를 작성해주세요!",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            40, // 좌우 여백 20씩 추가
                        height: 200, // 고정 높이 설정
                        padding: EdgeInsets.symmetric(horizontal: 16), // 내부 패딩
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색
                          borderRadius: BorderRadius.circular(8), // 테두리 둥글게
                          border: Border.all(
                            color: CatchmongColors.gray100, // 테두리 색상
                          ),
                        ),
                        child: TextField(
                          maxLines: null, // 여러 줄 허용
                          expands: true, // TextField가 Container에 꽉 차도록 설정
                          decoration: InputDecoration(
                            hintText:
                                "영업 방해 목적의 허위 사실, 악의적 비방이 담긴 후기는 신고 접수 과정을 통해 운영진의 검토를 거쳐 통보 없이 삭제될 수 있습니다.",
                            border: InputBorder.none, // 기본 border 제거
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: CatchmongColors.gray400,
                          ), // 텍스트 스타일 설정
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "사진/동영상 첨부하기",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 102,
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, idx) {
                              return idx == 0
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/img-plus.svg'),
                                          Text(
                                            "사진등록\n(3 / 120)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: CatchmongColors.sub_gray,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color: CatchmongColors.gray100,
                                          )),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: CatchmongColors.gray400,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              )
                                            ],
                                          ),
                                          Text(
                                            "첨부한\n가게사진",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: CatchmongColors.sub_gray,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color: CatchmongColors.gray100,
                                          )),
                                    );
                            }),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "무관한 사진/동영상을 첨부한 리뷰는 통보없이 삭제 및 혜택이 회수됩니다.",
                        style: TextStyle(
                          color: CatchmongColors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showPreview(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container(); //PartnerShowView();
    },
  );
}

void showStoreManage(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: DefaultAppbar(
            title: "가게 관리",
          ),
          body: SafeArea(
            child: Container(
              color: Colors.white,
              height: 182,
              child: Column(children: [
                InkWell(
                  onTap: () {
                    showStoreInfo(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 21,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CatchmongColors.gray50,
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "호박꽃마차 대전점",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // showStoreAdd(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 21,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CatchmongColors.gray50,
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "호박꽃마차 춘천점",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ));
    },
  );
}

void showStoreAdd(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: CatchmongColors.gray50,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8,
            ),
            child: YellowElevationBtn(
              onPressed: () {},
              title: Text("등록하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "가게 등록",
            onTap: () {
              showPreview(context);
            },
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            //가게명
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게명",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 48, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "가게명을 입력해주세요.",
                        border: InputBorder.none, // 기본 border 제거
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ), // 여백 설정
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray_800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //업태 , 카테고리
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 업태
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "업태",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectedBusinessType,
                            items: [
                              "선택",
                              "한식",
                              "중식",
                              "일식",
                              "양식",
                              "분식",
                              "패스트푸드",
                              "비건식당",
                              "디저트카페",
                              "뷔페"
                            ]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedBusinessType = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  // 카테고리
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectedCategory,
                            items: [
                              "선택",
                              "데이트 맛집",
                              "화제의 예능",
                              "가족 모임",
                              "혼밥",
                              "노포",
                              "인스타 핫플",
                              "룸이 있는",
                              "가성비 맛집",
                              "레스토랑",
                              "미슐랭",
                            ]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedCategory = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //사업자등록증 외 증빙서류
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "사업자등록증 외 증빙서류",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 102,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) {
                          return idx == 0
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SvgPicture.asset(
                                          'assets/images/img-plus.svg'),
                                      Text(
                                        "사진등록\n(3 / 120)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: CatchmongColors.gray400,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          )
                                        ],
                                      ),
                                      Text(
                                        "첨부한\n가게사진",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                );
                        }),
                  ),
                ],
              ),
            ),
            //업체 사진 (최소 3장)
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "업체 사진 (최소 3장)",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 102,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) {
                          return idx == 0
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SvgPicture.asset(
                                          'assets/images/img-plus.svg'),
                                      Text(
                                        "사진등록\n(3 / 120)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: CatchmongColors.gray400,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          )
                                        ],
                                      ),
                                      Text(
                                        "첨부한\n가게사진",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                );
                        }),
                  ),
                ],
              ),
            ),
            //주소
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "주소",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "검색한 우편번호로 불러온 주소 value",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      OutlinedBtn(
                          height: 48, width: 120, title: "우편번호", onPress: () {})
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 48, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "상세주소 입력",
                        border: InputBorder.none, // 기본 border 제거
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ), // 여백 설정
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray_800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //가게 전화번호
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게 전화번호",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //가게 소개
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게 소개",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 100, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: null, // 여러 줄 허용
                      expands: true, // TextField가 Container에 꽉 차도록 설정
                      decoration: InputDecoration(
                        hintText: "   소개문구를 작성해주세요.",
                        border: InputBorder.none, // 기본 border 제거
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray400,
                      ), // 텍스트 스타일 설정
                    ),
                  ),
                ],
              ),
            ),
            //편의시설
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "편의시설",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...[
                          "주차",
                          "쿠폰",
                          "유아시설",
                          "애견동반",
                          "예약",
                          "콜키지",
                          "단체석",
                          "배달",
                          "발렛"
                        ].map((data) {
                          return YellowToggleBtn(
                            width: MediaQuery.of(context).size.width / 3.6,
                            title: data,
                            isSelected: false,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //휴무일
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "휴무일",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...[
                          "있어요",
                          "없어요",
                        ].map((data) {
                          return YellowToggleBtn(
                            width: MediaQuery.of(context).size.width / 2.3,
                            title: data,
                            isSelected: data == "있어요" ? true : false,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //정기 휴무일
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 정기 휴무일 텍스트
                  Text(
                    "정기 휴무일",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 드롭다운
                  Container(
                    width: 130,
                    height: 48, // 드롭다운 높이
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: selectedDay,
                      items: [
                        "매 주",
                        "첫째 주",
                        "둘째 주",
                        "셋째 주",
                        "넷째 주",
                      ]
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: CatchmongColors.gray_800,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedDay = newValue; // 값 업데이트
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16),

                  // 요일 선택 버튼들
                  Wrap(
                    spacing: 4, // 버튼 사이 간격
                    runSpacing: 4, // 줄바꿈 시 간격
                    children: [
                      ...["월", "화", "수", "목", "금", "토", "일"].map((data) {
                        return YellowToggleBtn(
                          width: 42, // 버튼 너비
                          title: data,
                          isSelected: data == "수", // 기본 선택값
                          onTap: () {
                            // 요일 선택 시 동작 추가
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ), //휴무일
            //영업 시간 설정
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "영업 시간 설정" 텍스트
                  Text(
                    "영업 시간 설정",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Container(
                    width: width,
                    child: Wrap(
                      spacing: 4, // 버튼 사이 간격
                      runSpacing: 4, // 줄바꿈 시 간격
                      children: [
                        ...["매일 같아요", "평일/주말 달라요", "요일별로 달라요"].map((data) {
                          return YellowToggleBtn(
                            width: width / 3.6, // 버튼 너비
                            title: data,
                            isSelected: data == "수", // 기본 선택값
                            onTap: () {
                              // 요일 선택 시 동작 추가
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //영업 시간
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "영업 시간" 텍스트
                  Text(
                    "영업 시간",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "11:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "20:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "24h 운영",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //휴게 시간
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "휴게 시간" 텍스트
                  Text(
                    "휴게 시간",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "11:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "20:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "휴게시간 없어요",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]))));
    },
  );
}

void showMyStore(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppbar(title: "내 가게"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showStoreAdd(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 21,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CatchmongColors.gray50,
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "가게 등록",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showStoreManage(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 21,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CatchmongColors.gray50,
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "가게 관리",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showShareConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Text(
                    "초대 링크가 복사되었습니다.지금 공유해보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              InkWell(
                onTap: () {
                  // 확인 버튼의 동작 추가
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: CatchmongColors.gray_300,
                  ))),
                  height: 60,
                  child: Text(
                    "확인",
                    style: TextStyle(
                      color: CatchmongColors.blue1,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//임시 휴무 / 영업 시간
void showStoreVacationAndTime(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: CatchmongColors.gray50,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8,
            ),
            child: YellowElevationBtn(
              onPressed: () {},
              title: Text("등록하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: DefaultAppbar(
            title: "임시 휴무 / 영업 시간",
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            //휴무 설정
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "휴무 설정",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  //휴무 설정
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...[
                          "영업 시간 변경",
                          "자리 비움",
                          "임시 휴무",
                        ].map((data) {
                          return YellowToggleBtn(
                            width: data == "영업 시간 변경"
                                ? 121
                                : MediaQuery.of(context).size.width / 3.8,
                            title: data,
                            isSelected: data == "영업 시간 변경" ? true : false,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //날짜 설정
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "날짜 설정",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "2024-11-19 (화)",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "2024-11-20 (수)",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //영업 시간 설정
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "영업 시간 설정",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "09:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "11:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      YellowToggleBtn(
                          width: 121, title: "지금 영업 종료", isSelected: false)
                    ],
                  ),
                ],
              ),
            ),
          ]))));
    },
  );
}

//메뉴 등록
void showReservationSetting(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          backgroundColor: CatchmongColors.gray50,
          appBar: DefaultAppbar(
            title: "예약 설정",
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 16, top: 32),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      color: CatchmongColors.gray50,
                      width: 1,
                    ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "예약 설정",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 220,
                          child: Text(
                            "가게 예약을 설정할 수 있습니다.",
                            softWrap: true,
                            style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // 오른쪽에 스위치를 배치하기 위해 Spacer 사용
                    CupertinoSwitch(
                      value: false, // 현재 스위치 상태
                      onChanged: (bool value) {},
                      activeColor: CatchmongColors.blue1, // 스위치가 켜졌을 때 색상
                    ),
                  ],
                ),
              ),
            ],
          ))));
    },
  );
}

//메뉴 등록
void showMenuAdd(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: CatchmongColors.gray50,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8,
            ),
            child: YellowElevationBtn(
              onPressed: () {},
              title: Text("저장하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "메뉴 등록",
            onTap: () {},
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              //메뉴 등록 버튼 섹션
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 16,
                  right: 20,
                  bottom: 32,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ))),
                child: Column(children: [
                  //휴무 설정
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              SvgPicture.asset('assets/images/img-plus.svg'),
                              Text(
                                "사진등록",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CatchmongColors.sub_gray,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: CatchmongColors.gray100,
                              )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              //카테고리
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "카테고리",
                                          style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                  20,
                                                )),
                                                border: Border.all(
                                                  color: CatchmongColors.gray,
                                                )),
                                            child: Center(
                                              child: Text(
                                                "추가",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 4,
                                    ),
                                    //날짜 드롭박스
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      height: 48,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: "메인메뉴",
                                        items: [
                                          "메인메뉴",
                                          "사이드",
                                          "디저트",
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              //메뉴명
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "메뉴명",
                                          style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      height: 48, // TextField의 높이 명시적으로 설정
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CatchmongColors.gray100,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "메뉴명을 입력해주세요.",
                                          border:
                                              InputBorder.none, // 기본 border 제거
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ), // 여백 설정
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), //메뉴명
                              SizedBox(
                                height: 8,
                              ),
                              //가격
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "가격",
                                          style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      height: 48, // TextField의 높이 명시적으로 설정
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CatchmongColors.gray100,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "금액을 입력해주세요.",
                                          border:
                                              InputBorder.none, // 기본 border 제거
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ), // 여백 설정
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  OutlinedBtn(width: width - 40, title: "등록하기", onPress: () {})
                ]),
              ),
              //메뉴 리스트 아이템
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 16,
                  right: 20,
                  bottom: 32,
                ),
                width: width,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: CatchmongColors.gray,
                            width: 1,
                          ), // 외부 테두리
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(8), // 이미지를 둥글게 자르기
                          child: Image.asset(
                            'assets/images/review2.jpg', // 이미지 경로
                            fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "아보카도 치폴레 크림 쉬림프",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "12,800원",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/images/trash.svg')
                  ],
                ),
              )
            ],
          ))));
    },
  );
}

void showStoreEdit(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: CatchmongColors.gray50,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8,
            ),
            child: YellowElevationBtn(
              onPressed: () {},
              title: Text("등록하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "가게 정보 수정",
            onTap: () {
              showPreview(context);
            },
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            //가게명
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게명",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 48, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "가게명을 입력해주세요.",
                        border: InputBorder.none, // 기본 border 제거
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ), // 여백 설정
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray_800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //업태 , 카테고리
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 업태
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "업태",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectedBusinessType,
                            items: [
                              "선택",
                              "한식",
                              "중식",
                              "일식",
                              "양식",
                              "분식",
                              "패스트푸드",
                              "비건식당",
                              "디저트카페",
                              "뷔페"
                            ]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedBusinessType = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  // 카테고리
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(
                            color: CatchmongColors.gray_800,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectedCategory,
                            items: [
                              "선택",
                              "데이트 맛집",
                              "화제의 예능",
                              "가족 모임",
                              "혼밥",
                              "노포",
                              "인스타 핫플",
                              "룸이 있는",
                              "가성비 맛집",
                              "레스토랑",
                              "미슐랭",
                            ]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedCategory = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //사업자등록증 외 증빙서류
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "사업자등록증 외 증빙서류",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 102,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) {
                          return idx == 0
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SvgPicture.asset(
                                          'assets/images/img-plus.svg'),
                                      Text(
                                        "사진등록\n(3 / 120)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: CatchmongColors.gray400,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          )
                                        ],
                                      ),
                                      Text(
                                        "첨부한\n가게사진",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                );
                        }),
                  ),
                ],
              ),
            ),
            //업체 사진 (최소 3장)
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "업체 사진 (최소 3장)",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 102,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) {
                          return idx == 0
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SvgPicture.asset(
                                          'assets/images/img-plus.svg'),
                                      Text(
                                        "사진등록\n(3 / 120)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: CatchmongColors.gray400,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          )
                                        ],
                                      ),
                                      Text(
                                        "첨부한\n가게사진",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CatchmongColors.sub_gray,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: CatchmongColors.gray100,
                                      )),
                                );
                        }),
                  ),
                ],
              ),
            ),
            //주소
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "주소",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "검색한 우편번호로 불러온 주소 value",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      OutlinedBtn(
                          height: 48, width: 120, title: "우편번호", onPress: () {})
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 48, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "상세주소 입력",
                        border: InputBorder.none, // 기본 border 제거
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ), // 여백 설정
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray_800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //가게 전화번호
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게 전화번호",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //가게 소개
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가게 소개",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 100, // TextField의 높이 명시적으로 설정
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: null, // 여러 줄 허용
                      expands: true, // TextField가 Container에 꽉 차도록 설정
                      decoration: InputDecoration(
                        hintText: "   소개문구를 작성해주세요.",
                        border: InputBorder.none, // 기본 border 제거
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray400,
                      ), // 텍스트 스타일 설정
                    ),
                  ),
                ],
              ),
            ),
            //편의시설
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "편의시설",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...[
                          "주차",
                          "쿠폰",
                          "유아시설",
                          "애견동반",
                          "예약",
                          "콜키지",
                          "단체석",
                          "배달",
                          "발렛"
                        ].map((data) {
                          return YellowToggleBtn(
                            width: MediaQuery.of(context).size.width / 3.6,
                            title: data,
                            isSelected: false,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //휴무일
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "휴무일",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...[
                          "있어요",
                          "없어요",
                        ].map((data) {
                          return YellowToggleBtn(
                            width: MediaQuery.of(context).size.width / 2.3,
                            title: data,
                            isSelected: data == "있어요" ? true : false,
                            onTap: () {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //정기 휴무일
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 정기 휴무일 텍스트
                  Text(
                    "정기 휴무일",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 드롭다운
                  Container(
                    width: 130,
                    height: 48, // 드롭다운 높이
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CatchmongColors.gray100,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: selectedDay,
                      items: [
                        "매 주",
                        "첫째 주",
                        "둘째 주",
                        "셋째 주",
                        "넷째 주",
                      ]
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: CatchmongColors.gray_800,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedDay = newValue; // 값 업데이트
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16),

                  // 요일 선택 버튼들
                  Wrap(
                    spacing: 4, // 버튼 사이 간격
                    runSpacing: 4, // 줄바꿈 시 간격
                    children: [
                      ...["월", "화", "수", "목", "금", "토", "일"].map((data) {
                        return YellowToggleBtn(
                          width: 42, // 버튼 너비
                          title: data,
                          isSelected: data == "수", // 기본 선택값
                          onTap: () {
                            // 요일 선택 시 동작 추가
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ), //휴무일
            //영업 시간 설정
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "영업 시간 설정" 텍스트
                  Text(
                    "영업 시간 설정",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Container(
                    width: width,
                    child: Wrap(
                      spacing: 4, // 버튼 사이 간격
                      runSpacing: 4, // 줄바꿈 시 간격
                      children: [
                        ...["매일 같아요", "평일/주말 달라요", "요일별로 달라요"].map((data) {
                          return YellowToggleBtn(
                            width: width / 3.6, // 버튼 너비
                            title: data,
                            isSelected: data == "수", // 기본 선택값
                            onTap: () {
                              // 요일 선택 시 동작 추가
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //영업 시간
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "영업 시간" 텍스트
                  Text(
                    "영업 시간",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "11:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "20:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "24h 운영",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //휴게 시간
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "휴게 시간" 텍스트
                  Text(
                    "휴게 시간",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 버튼 그룹
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "11:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "20:00",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 48, // TextField의 높이 명시적으로 설정
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "휴게시간 없어요",
                              border: InputBorder.none, // 기본 border 제거
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ), // 여백 설정
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]))));
    },
  );
}
