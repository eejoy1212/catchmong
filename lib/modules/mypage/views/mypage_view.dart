import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/controller/reservation_controller.dart';
import 'package:catchmong/controller/review_controller.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/model/menu.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/reservation.dart';
import 'package:catchmong/model/reservation_setting.dart';
import 'package:catchmong/modules/location/scrap/views/scrap_view.dart';
import 'package:catchmong/modules/location/views/location_search_view.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/modules/mypage/views/mypage_setting.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:catchmong/widget/bar/close_appbar.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/bar/preview_appbar.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/datepick_btn.dart';
import 'package:catchmong/widget/button/outline_btn_with_icon.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/partner-review-card.dart';
import 'package:catchmong/widget/card/partner_img_card.dart';
import 'package:catchmong/widget/card/reservation_status_card.dart';
import 'package:catchmong/widget/chart/horizontal_stacked_bar_chart.dart';
import 'package:catchmong/widget/chart/half_pie_chart.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:catchmong/widget/dialog/UseDialog.dart';
import 'package:catchmong/widget/section/reservation_register_section.dart';
import 'package:catchmong/widget/section/written_reservation_register_section.dart';
import 'package:catchmong/widget/txtarea/border_txtarea.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MyPageView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  final MypageController myPageController = Get.find<MypageController>();
  final ReservationConteroller reservationController =
      Get.find<ReservationConteroller>();
  @override
  Widget build(BuildContext context) {
    bool isLogin = loginController.user.value != null;

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
                          child: ImgCard(
                              path:
                                  '${loginController.baseUrl}/${loginController.user.value?.picture}')),
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        )
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
            onTap: () async {
              await loginController.fetchScrapedPartners();
              showScrapedPartners(context);
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
                  // Image.asset('assets/images/right-arrow.png')
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
          )
          //타일 1-내 예약
          ,
          InkWell(
            onTap: () async {
              await reservationController
                  .fetchReservations(loginController.user.value!.id);

              showReservationDialog(context);
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
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
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

void showScrapedPartners(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  final LoginController loginController = Get.find<LoginController>();

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScrapView(
        partners: loginController.scrapedPartners,
      );
    },
  );
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

//내 예약 창
void showReservationDialog(BuildContext context) {
  final ReservationConteroller controller = Get.find<ReservationConteroller>();
  final LoginController loginController = Get.find<LoginController>();
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  String getTitle(int idx) {
    switch (idx) {
      case 0:
        return "전체";
      case 1:
        return "예약대기";
      case 2:
        return "예약확정";
      case 3:
        return "이용완료";
      case 4:
        return "예약취소";
      default:
        return "예약확정";
    }
  }

  String getStatus(String status) {
    switch (status) {
      case "PENDING":
        return "예약대기";
      case "CONFIRMED":
        return "예약확정";
      case "COMPLETED":
        return "이용완료";
      case "CANCELLED":
        return "예약취소";
      default:
        return "예약대기";
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "PENDING":
        return CatchmongColors.red;
      case "CONFIRMED":
        return CatchmongColors.blue2;
      case "COMPLETED":
        return CatchmongColors.gray_800;
      case "CANCELLED":
        return CatchmongColors.gray_800;
      default:
        return CatchmongColors.red;
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      print("내 예약${controller.reservations.length}");
      return Scaffold(
        appBar: DefaultAppbar(title: "내 예약"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ))),
                width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 48,
                      width: 96,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() => DropdownButton<String>(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: CatchmongColors.black,
                            ),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: controller.selectedDatePickType.value,
                            items: controller.datepickType
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.selectedDatePickType.value =
                                    newValue;
                              }
                            },
                          )),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Obx(() => DatePickBtn(
                            startDate: controller.selectedDate[0].value,
                            endDate: controller.selectedDate[1].value,
                            onPress: () async {
                              await controller.selectDate(context);
                              await controller.fetchReservations(
                                  loginController.user.value!.id);
                            }))),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 36,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() => MapChip(
                              onTap: () async {
                                controller.sortType.value = index;

                                await controller.fetchReservations(
                                    loginController.user.value!.id);
                              },
                              title: getTitle(index),
                              isActive: controller.sortType.value == index,
                              marginRight: 8,
                              leadingIcon: Container(),
                              useLeadingIcon: false,
                            ));
                      }),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              //예약대기 & 예약 확정
              Obx(() => controller.reservations.isEmpty
                  ? Container(
                      width: width,
                      height: 500,
                      child: Center(
                        child: Text("예약이 없습니다."),
                      ),
                    )
                  : Container(
                      width: width,
                      // constraints: BoxConstraints(
                      //   minHeight: 500,
                      // ),
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      height: height - 300,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              color: CatchmongColors.gray50,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: controller.reservations.length,
                          itemBuilder: (BuildContext context, int index) {
                            final reservation = controller.reservations[index];
                            return Opacity(
                              opacity: reservation.status == "COMPLETED" ||
                                      reservation.status == "CANCELLED"
                                  ? 0.6
                                  : 1,
                              child: Container(
                                width: width,
                                height: 220,
                                margin: EdgeInsets.only(
                                  left: 20,
                                  top: 16,
                                  right: 20,
                                  bottom: 32,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getStatus(reservation.status),
                                      style: TextStyle(
                                        color:
                                            getStatusColor(reservation.status),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                              color: CatchmongColors.gray,
                                              width: 1,
                                            ), // 외부 테두리
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8), // 이미지를 둥글게 자르기
                                            child: ImgCard(
                                                path: "http://$myPort:3000" +
                                                    "/" +
                                                    reservation.partner
                                                        .storePhotos![0]),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.formatReservationTime(
                                                    reservation
                                                        .reservationStartDate),
                                                style: TextStyle(
                                                  color: CatchmongColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                reservation.partner.name,
                                                style: TextStyle(
                                                  color: CatchmongColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                // "",
                                                controller
                                                    .formatReservationDate([
                                                  reservation
                                                      .reservationStartDate,
                                                  reservation
                                                      .reservationEndDate,
                                                ]),
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: CatchmongColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "${reservation.numOfPeople}명",
                                          style: TextStyle(
                                            color: CatchmongColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    OutlinedBtn(
                                        width: width,
                                        title: "취소하기",
                                        onPress: () {
                                          showCancelDialog(
                                              context, reservation.id);
                                        })
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
            ],
          ),
        ),
      );
    },
  );
}

//취소하기 창
void showCancelDialog(BuildContext context, int reservationId) {
  String selectedReason = ""; // 선택된 취소 사유를 저장할 변수
  double width = MediaQuery.of(context).size.width;
  final TextEditingController txtController = TextEditingController();
  final List<String> reasons = [
    "개인 사정으로 방문이 어렵습니다.",
    "예약 날짜 및 시간 변경이 필요합니다.",
    "단순 변심",
    "기타 (직접 입력)",
  ];
  final ReservationConteroller conteroller = Get.find<ReservationConteroller>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "사장님께 예약 취소 사유를 알려주세요 🥲",
          style: TextStyle(
            color: CatchmongColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          height: 450, // 리스트 높이 조정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 라디오 버튼과 텍스트 리스트
              Expanded(
                child: ListView.separated(
                  itemCount: reasons.length + 1,
                  separatorBuilder: (context, index) => Divider(
                    color: reasons.length - 1 == index
                        ? Colors.transparent
                        : CatchmongColors.gray50, // 구분선 색상
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    return index == reasons.length
                        ? SizedBox(
                            width: width,
                            height: 100,
                            child: Obx(() => BorderTxtarea(
                                readOnly: conteroller.reasonIdx.value != 3,
                                width: width,
                                hintText: "내용을 작성해주세요.",
                                controller: txtController,
                                onChanged: (String value) {
                                  conteroller.cancelReason.value = value;
                                  if (txtController.text.length > 300) {
                                    Future.microtask(() {
                                      txtController.value = TextEditingValue(
                                        text: value.substring(0, 300),
                                        selection: TextSelection.collapsed(
                                            offset: 300),
                                      );
                                    });
                                  }
                                })),
                          )
                        : ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Obx(() => Radio<String>(
                                  activeColor: CatchmongColors.yellow_main,
                                  value: reasons[index],
                                  groupValue:
                                      reasons[conteroller.reasonIdx.value],
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      conteroller.reasonIdx.value = index;
                                      if (index == 3) {
                                        conteroller.cancelReason.value = "";
                                      } else {
                                        conteroller.cancelReason.value = value;
                                      }
                                    }
                                  },
                                )),
                            title: Text(reasons[index]),
                          );
                  },
                ),
              ),
              SizedBox(
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () async {
                          print("선택된 취소 사유: ${conteroller.cancelReason.value}");
                          if (conteroller.cancelReason.value.trim() == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("취소 사유를 선택해주세요.")),
                            );
                            return;
                          }
                          await conteroller.patchCancelReservation(
                              reservationId: reservationId);
                          Get.back(); // 다이얼로그 닫기
                          Get.snackbar(
                            "알림",
                            "예약이 취소되었습니다.",
                            snackPosition: SnackPosition.TOP, // 상단에 표시
                            backgroundColor: CatchmongColors.yellow_main,
                            colorText: CatchmongColors.black,
                            icon: Icon(Icons.check_circle,
                                color: CatchmongColors.black),
                            duration: Duration(seconds: 1),
                            borderRadius: 10,
                            margin: EdgeInsets.all(10),
                          );
                          // 선택된 취소 사유 처리
                        },
                        title: Text(
                          "확인",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () {
                          Get.back(); // 다이얼로그 닫기
                          // 선택된 취소 사유 처리
                          print("선택된 취소 사유: ${conteroller.cancelReason.value}");
                        },
                        title: Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

void showStoreInfo(BuildContext context, Partner store) {
  print("in showStoreInfo>>> ${store}");
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
  final Partner2Controller controller = Get.find<Partner2Controller>();
  final LoginController loginController = Get.find<LoginController>();
  final ReservationConteroller reservationController =
      Get.find<ReservationConteroller>();
  final ReviewController reviewController = Get.find<ReviewController>();
  final dateFormatter = DateFormat('yyyy.MM.dd');
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "닫기",
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: CatchmongColors.gray50,
        appBar: DefaultAppbar(title: store.name),
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
                    onTap: (int idx) async {
                      if (idx == 0) {
                      } else if (idx == 1) {
                        await reservationController.fetchPartnerReservations(
                            partnerId: store.id!);
                      } else if (idx == 2) {
                        if (store.id != null) {
                          await reviewController.fetchPartnerReviews(store.id!);
                        }
                      } else {}
                    },
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Obx(
                                          () => DropdownButton<String>(
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            value: controller
                                                .selectedStatisticsItem.value,
                                            items: controller.statisticsItems
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
                                              if (newValue != null) {
                                                controller
                                                    .selectedStatisticsItem
                                                    .value = newValue;
                                              }
                                            },
                                          ),
                                        )),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Obx(
                                          () => DropdownButton<String>(
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            value: reservationController
                                                .selectedDateItem.value,
                                            items: reservationController
                                                .dateItems
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
                                              if (newValue != null) {
                                                reservationController
                                                    .selectedDateItem
                                                    .value = newValue;
                                              }
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //연도
                                    // Expanded(
                                    //   child: Obx(() => OutlinedBtn(
                                    //       height: 48,
                                    //       title:
                                    //           '${dateFormatter.format(reservationController.selectedResDate[0].value)}~${dateFormatter.format(reservationController.selectedResDate[1].value)}',
                                    // onPress: () async {
                                    //   await reservationController
                                    //       .selectReservationDate(context);
                                    //   reservationController
                                    //       .fetchPartnerReservations(
                                    //           partnerId: store.id!);
                                    // })),
                                    // )
                                    Expanded(
                                        child: Obx(() => DatePickBtn(
                                            startDate: reservationController
                                                .selectedResDate[0].value,
                                            endDate: reservationController
                                                .selectedResDate[1].value,
                                            onPress: () async {
                                              await reservationController
                                                  .selectReservationDate(
                                                      context);
                                              reservationController
                                                  .fetchPartnerReservations(
                                                      partnerId: store.id!);
                                            })))
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
                                                onTap: () async {
                                                  await reservationController
                                                      .fetchReservations(
                                                          loginController
                                                              .user.value!.id);

                                                  showReservationDialog(
                                                      context);
                                                },
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
                                                onTap: () {
                                                  reservationController
                                                      .fetchPartnerReservations(
                                                          partnerId: store.id!);
                                                },
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
                                                Obx(
                                                  () => Text(
                                                    reservationController
                                                        .myReservations
                                                        .where((el) =>
                                                            el.status ==
                                                            "PENDING")
                                                        .length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.red,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
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
                                                Obx(
                                                  () => Text(
                                                    reservationController
                                                        .myReservations
                                                        .where((el) =>
                                                            el.status ==
                                                            "CONFIRMED")
                                                        .length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.blue1,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
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
                                                Obx(() => Text(
                                                      reservationController
                                                          .myReservations
                                                          .where((el) =>
                                                              el.status ==
                                                              "COMPLETED")
                                                          .length
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: CatchmongColors
                                                            .gray_800,
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    )),
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
                                                Obx(() => Text(
                                                      reservationController
                                                          .myReservations
                                                          .where((el) =>
                                                              el.status ==
                                                              "CANCELLED")
                                                          .length
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: CatchmongColors
                                                            .gray_800,
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    )),
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
                                width: width,
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
                                    Obx(() {
                                      final reservations =
                                          reservationController.myReservations;

                                      if (reservations.isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                            child: Text(
                                              "예약 내역이 없습니다.",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      // 예약 상태 카드 동적 생성
                                      return Column(
                                        children: List.generate(
                                          reservations.length,
                                          (idx) {
                                            ReservationStatus getStatus(
                                                String status) {
                                              switch (status) {
                                                case "PENDING":
                                                  return ReservationStatus
                                                      .waiting;
                                                case "CONFIRMED":
                                                  return ReservationStatus
                                                      .confirmed;
                                                case "COMPLETED":
                                                  return ReservationStatus
                                                      .completed;
                                                default:
                                                  return ReservationStatus
                                                      .cancelled;
                                              }
                                            }

                                            return ReservationStatusCard(
                                              width: width,
                                              reservation: reservations[
                                                  idx], // 각 예약의 상태에 따라 처리
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // 리뷰 탭
                      Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Obx(
                                () => reviewController.partnerReviews.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(
                                          child: Text(
                                            "리뷰 내역이 없습니다.",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          ...List.generate(
                                              reviewController.partnerReviews
                                                  .length, (int idx) {
                                            final review = reviewController
                                                .partnerReviews[idx];
                                            return PartnerReviewCard(
                                              onReplyTap: () {
                                                showReplyWrite(context);
                                              },
                                              review: review,
                                            );
                                          })
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
                                      )),
                          )),

                      // 설정 탭
                      Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //가게 정보 수정
                                InkWell(
                                  onTap: () async {
                                    if (store.id != null) {
                                      await controller
                                          .fetchPartnerDetails(store.id!);
                                      showStoreEdit(context, store.id!);
                                    }
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
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        )
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
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (store.id != null) {
                                      await controller
                                          .fetchMenusByPartnerId(store.id!);
                                      showMenuAdd(context, store);
                                    }
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
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (store.id != null) {
                                      await reservationController
                                          .fetchReservationSettings(store.id!);
                                      showReservationSetting(
                                          context, store.id!);
                                    }
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
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        )
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

// void showPreview(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;
//   String selectedBusinessType = "선택"; // 업태 기본값
//   String selectedCategory = "선택"; // 카테고리 기본값
//   String selectedDay = "매 주"; // 정기 휴무일 기본값
//   final Partner2Controller controller = Get.find<Partner2Controller>();
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
//     barrierLabel: "닫기", // 접근성 레이블 설정
//     barrierColor: Colors.black54, // 배경 색상
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return  PartnerShowView(partner: controller.newPartner.value!, businessStatus: '', rating: null, replyCount: '',);
//     },
//   );
// }

void showStoreManage(BuildContext context) {
  final Partner2Controller controller = Get.find<Partner2Controller>();
  final LoginController loginController = Get.find<LoginController>();
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "닫기",
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppbar(title: "가게 관리"),
        body: SafeArea(
          child: FutureBuilder<List<Partner>>(
            future:
                controller.fetchUserPartners(loginController.user.value!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // 로딩 표시
              } else if (snapshot.hasError) {
                return Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('등록된 가게가 없습니다.'));
              }

              final storeList = snapshot.data!;

              return ListView.builder(
                itemCount: storeList.length,
                itemBuilder: (context, index) {
                  final store = storeList[index];
                  print("유저의 가게들 ${store.name}");
                  return InkWell(
                    onTap: () {
                      showStoreInfo(context, store);
                      // showStoreInfo(context, store['id']); // 가게 정보 상세보기
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 21, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.name, // 서버에서 가져온 가게 이름
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}

void showStoreAdd(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값
  final Partner2Controller controller = Get.find<Partner2Controller>();
  final LoginController loginController = Get.find<LoginController>();
  String _formatPhoneNumber(String input) {
    // 숫자만 추출
    String digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    print("digits>>> $input");
    // 최대 길이 제한: "010-1234-5678" => 13자리
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    // 형식 적용: 010-XXXX-XXXX
    if (digits.length <= 3) {
      return digits; // 3자리 이하
    } else if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}'; // 3-4 형식
    } else {
      return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}'; // 3-4-4 형식
    }
  }

  List<String> _getbusinessTimeTitles(String type) {
    switch (type) {
      case "매일 같아요":
        return ["영업 시간", "영업 시간"];
      case "평일/주말 달라요":
        return ["평일 영업 시간", "주말 영업 시간"];
      case "요일별로 달라요":
        return [
          "월요일 영업 시간",
          "화요일 영업 시간",
          "수요일 영업 시간",
          "목요일 영업 시간",
          "금요일 영업 시간",
          "토요일 영업 시간",
          "일요일 영업 시간"
        ];
      default:
        return ["영업 시간", "영업 시간"];
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      final bTitles =
          _getbusinessTimeTitles(controller.selectedBusinessTimeConfig.value);
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
              onPressed: () async {
                await controller.addNewPartner();
                // showPreview(context);
                final partner = controller.newPartner.value;
                if (partner != null) {
                  final businessStatus = controller.getBusinessStatus(
                    partner.businessTime ?? "",
                    partner.breakTime,
                    partner.regularHoliday,
                  );
                  if (partner.storePhotos == null ||
                      partner.storePhotos!.length < 3) {
                    Get.snackbar(
                      "알림",
                      "업체 사진을 최소 3장이상 등록 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.businessProofs == null ||
                      partner.businessProofs!.length < 1) {
                    Get.snackbar(
                      "알림",
                      "증빙서류를 최소 1장이상 등록 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.address.trim() == "") {
                    Get.snackbar(
                      "알림",
                      "주소를 입력 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.phone.trim() == "") {
                    Get.snackbar(
                      "알림",
                      "가게 전화번호를 입력 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else {
                    controller.showSelectedPartner(
                      context,
                      partner,
                      businessStatus,
                      5.0,
                      "리뷰 0",
                    );
                  }

                  controller.addPostPartner(
                      userId: loginController.user.value!.id);
                  Get.back(closeOverlays: true);

                  // /main으로 이동
                  Get.offAllNamed('/main');
                }
              },
              title: Text("등록하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "가게 등록",
            onTap: () async {
              await controller.addNewPartner();
              // showPreview(context);
              final partner = controller.newPartner.value;
              if (partner != null) {
                final businessStatus = controller.getBusinessStatus(
                  partner.businessTime ?? "",
                  partner.breakTime,
                  partner.regularHoliday,
                );
                if (partner.storePhotos == null ||
                    partner.storePhotos!.length < 3) {
                  Get.snackbar(
                    "알림",
                    "업체 사진을 최소 3장이상 등록 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.businessProofs == null ||
                    partner.businessProofs!.length < 1) {
                  Get.snackbar(
                    "알림",
                    "증빙서류를 최소 1장이상 등록 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.address.trim() == "") {
                  Get.snackbar(
                    "알림",
                    "주소를 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.phone.trim() == "") {
                  Get.snackbar(
                    "알림",
                    "가게 전화번호를 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else {
                  controller.showSelectedPartner(
                    context,
                    partner,
                    businessStatus,
                    5.0,
                    "리뷰 0",
                  );
                }
              }
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
                  BorderTxtField(
                    hintText: "가게명을 입력해주세요.",
                    controller: controller.partnerNameTxtController,
                    onChanged: (String value) {
                      if (controller.partnerNameTxtController.text.length >
                          300) {
                        Future.microtask(() {
                          controller.partnerNameTxtController.value =
                              TextEditingValue(
                            text: value.substring(0, 300),
                            selection: TextSelection.collapsed(offset: 300),
                          );
                        });
                      }
                    },
                  )
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
                            child: Obx(
                              () => DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: controller.selectedFoodType.value,
                                items: controller.foodTypes
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
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
                                    controller.selectedFoodType.value =
                                        newValue;
                                  }
                                },
                              ),
                            )),
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
                            child: Obx(
                              () => DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: controller.selectedCategory.value,
                                items: controller.categories
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
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
                                    controller.selectedCategory.value =
                                        newValue;
                                  }
                                },
                              ),
                            )),
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
                  Obx(
                    () => SizedBox(
                      height: 102,
                      child: ListView.builder(
                          itemCount: controller.businessProofs.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, idx) {
                            if (idx == 0) {
                              return InkWell(
                                onTap: () async {
                                  print("갤러리 열기");
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource
                                        .gallery, // or ImageSource.camera
                                    maxWidth: 800, // Optional: Resize the image
                                    maxHeight: 800,
                                  );

                                  if (pickedFile != null) {
                                    controller.businessProofs.add(pickedFile);
                                    final newImagePath = pickedFile.path;
                                  }
                                },
                                child: Container(
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
                                        "사진등록\n(${controller.businessProofs.length} / 120)",
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
                              );
                            } else {
                              final String? imagePath =
                                  controller.businessProofs[idx - 1].path;
                              print("imagePath: $imagePath");

                              return PartnerImgCard(
                                path: imagePath,
                                isLocal: true, // 로컬 이미지 여부 전달
                                onDelete: () {
                                  // if (controller.editing.value != null) {
                                  //   controller.editing.value =
                                  //       controller.editing.value!.copyWith(
                                  //     images: controller.editing.value!.images!
                                  //       ..removeAt(idx - 1),
                                  //   );
                                  // }
                                  controller.businessProofs.removeAt(idx - 1);
                                },
                                onTab: () {
                                  print("Tapped image at index $idx");
                                },
                              );
                            }
                          }),
                    ),
                  )
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
                  Obx(
                    () => SizedBox(
                      height: 102,
                      child: ListView.builder(
                          itemCount: controller.storePhotos.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, idx) {
                            if (idx == 0) {
                              return InkWell(
                                onTap: () async {
                                  print("갤러리 열기");
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource
                                        .gallery, // or ImageSource.camera
                                    maxWidth: 800, // Optional: Resize the image
                                    maxHeight: 800,
                                  );

                                  if (pickedFile != null) {
                                    final newImagePath = pickedFile.path;
                                    controller.storePhotos.add(pickedFile);
                                  }
                                },
                                child: Container(
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
                                        "사진등록\n(${controller.storePhotos.length} / 120)",
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
                              );
                            } else {
                              final String? imagePath =
                                  controller.storePhotos[idx - 1].path;
                              print("imagePath: $imagePath");

                              return PartnerImgCard(
                                path: imagePath,
                                isLocal: true, // 로컬 이미지 여부 전달
                                onDelete: () {
                                  // if (controller.editing.value != null) {
                                  //   controller.editing.value =
                                  //       controller.editing.value!.copyWith(
                                  //     images: controller.editing.value!.images!
                                  //       ..removeAt(idx - 1),
                                  //   );
                                  // }

                                  controller.storePhotos.removeAt(idx - 1);
                                },
                                onTab: () {
                                  print("Tapped image at index $idx");
                                },
                              );
                            }
                          }),
                    ),
                  )
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
                          child: Obx(() => BorderTxtField(
                              readOnly: true,
                              hintText: "우편번호",
                              controller: TextEditingController(
                                  text: controller.postCode.value),
                              onChanged: (String value) {}))),
                      SizedBox(
                        width: 8,
                      ),
                      OutlinedBtn(
                          height: 48,
                          width: 120,
                          title: "우편번호",
                          onPress: () async {
                            DataModel model = await Get.to(
                              () => LocationSearchView(),
                            );
                            // onSearch(model);
                            print("주소 검색 결과>>> ${model.address}");
                            controller.postCode.value = model.zonecode;
                            controller.address.value = model.address;
                          })
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => BorderTxtField(
                      readOnly: true,
                      hintText: "상세주소",
                      controller: TextEditingController(
                        text: controller.address.value,
                      ),
                      onChanged: (String value) {}))
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
                  BorderTxtField(
                    controller: controller.phoneTxtController,
                    onChanged: (String value) {
                      String formattedValue = _formatPhoneNumber(value);
                      controller.phoneTxtController.text = formattedValue;
                    },
                  )
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
                      controller: controller.descriptionTxtController,
                      onChanged: (String value) {
                        if (controller.descriptionTxtController.text.length >
                            300) {
                          Future.microtask(() {
                            controller.descriptionTxtController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                      maxLines: null, // 여러 줄 허용
                      expands: true, // TextField가 Container에 꽉 차도록 설정
                      decoration: InputDecoration(
                          hintText: "   소개문구를 작성해주세요.",
                          border: InputBorder.none, // 기본 border 제거
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8)),
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
                        ...controller.amenities.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: MediaQuery.of(context).size.width / 3.6,
                                title: data,
                                isSelected:
                                    controller.selectedAmenities.contains(data),
                                onTap: () {
                                  if (controller.selectedAmenities
                                      .contains(data)) {
                                    controller.selectedAmenities.remove(data);
                                  } else {
                                    controller.selectedAmenities.add(data);
                                  }
                                },
                              ));
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
                        ...controller.holidays.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: MediaQuery.of(context).size.width / 2.3,
                                title: data,
                                isSelected: data == "있어요"
                                    ? controller.hasHoliday.value
                                    : !controller.hasHoliday.value,
                                onTap: () {
                                  if (data == "있어요") {
                                    controller.hasHoliday.value = true;
                                  } else {
                                    controller.hasHoliday.value = false;
                                  }
                                },
                              ));
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
                    child: Obx(() => DropdownButton<String>(
                          isExpanded: true,
                          underline: SizedBox(),
                          value: controller.selectedHolidayWeek.value,
                          items: controller.holidayWeeks
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
                              controller.selectedHolidayWeek.value =
                                  newValue; // 값 업데이트
                            }
                          },
                        )),
                  ),
                  SizedBox(height: 16),

                  // 요일 선택 버튼들
                  Wrap(
                    spacing: 4, // 버튼 사이 간격
                    runSpacing: 4, // 줄바꿈 시 간격
                    children: [
                      ...controller.regularHolidays.map((data) {
                        return Obx(() => YellowToggleBtn(
                              width: 42, // 버튼 너비
                              title: data,
                              isSelected: controller.selectedRegularHoliday ==
                                  data, // 기본 선택값
                              onTap: () {
                                controller.selectedRegularHoliday.value = data;
                                // 요일 선택 시 동작 추가
                              },
                            ));
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
                        ...controller.businessTimeConfigs.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: width / 3.6, // 버튼 너비
                                title: data,
                                isSelected: controller
                                        .selectedBusinessTimeConfig.value ==
                                    data, // 기본 선택값
                                onTap: () {
                                  controller.selectedBusinessTimeConfig.value =
                                      data;

                                  // 선택된 값에 따라 businessTime 업데이트
                                  if (data == "매일 같아요") {
                                    controller.businessTime["titles"] = [
                                      "영업 시간"
                                    ];
                                    controller.businessTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                    controller.holidayTime["titles"] = [
                                      "휴게 시간"
                                    ];
                                    controller.holidayTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                  } else if (data == "평일/주말 달라요") {
                                    controller.businessTime["titles"] =
                                        ["평일 영업 시간", "주말 영업 시간"].obs;
                                    controller.businessTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                    controller.holidayTime["titles"] =
                                        ["평일 휴게 시간", "주말 휴게 시간"].obs;
                                    controller.holidayTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                  } else {
                                    controller.businessTime["titles"] = [
                                      "월요일 영업 시간",
                                      "화요일 영업 시간",
                                      "수요일 영업 시간",
                                      "목요일 영업 시간",
                                      "금요일 영업 시간",
                                      "토요일 영업 시간",
                                      "일요일 영업 시간"
                                    ].obs;
                                    controller.businessTime["times"] =
                                        List.generate(
                                      7,
                                      (index) => {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    );
                                    controller.holidayTime["titles"] = [
                                      "월요일 휴게 시간",
                                      "화요일 휴게 시간",
                                      "수요일 휴게 시간",
                                      "목요일 휴게 시간",
                                      "금요일 휴게 시간",
                                      "토요일 휴게 시간",
                                      "일요일 휴게 시간"
                                    ].obs;
                                    controller.holidayTime["times"] =
                                        List.generate(
                                      7,
                                      (index) => {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    );
                                  }

                                  // 업데이트 후 UI 반영
                                  controller.businessTime.refresh();
                                },
                              ));
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 매일같아요/평일주말달라요/요일별로달라요-영업시간
            Obx(
              () => Column(
                children: [
                  ...List.generate(
                    controller.businessTime["titles"]!.length,
                    (int index) => Container(
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
                            controller.businessTime["titles"]![index],
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller
                                              .businessTime["times"]![index]
                                          ["time"][0],
                                      onPress: () {
                                        if (controller.businessTime["times"]![
                                                index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.businessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][0] = value;
                                            controller.businessTime["times"]![
                                                index]["time"] = copied;
                                          });
                                        }
                                      }))),
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller
                                              .businessTime["times"]![index]
                                          ["time"][1],
                                      onPress: () {
                                        if (controller.isAllDay.isFalse) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.businessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][1] = value;
                                            controller.businessTime["times"]![
                                                index]["time"] = copied;
                                          });
                                        }
                                      }))),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => YellowToggleBtn(
                                  width: 100,
                                  title: "24h 운영",
                                  isSelected:
                                      controller.businessTime["times"]![index]
                                          ["allDay"], // 현재 상태
                                  onTap: () {
                                    // allDay 값 토글
                                    controller.businessTime["times"]![index]
                                        ["allDay"] = !controller
                                            .businessTime["times"]![index]
                                        ["allDay"];

                                    // 시간 데이터 업데이트
                                    if (controller.businessTime["times"]![index]
                                            ["allDay"] ==
                                        true) {
                                      controller.businessTime["times"]![index]
                                          ["time"] = ["00:00", "24:00"];
                                    } else {
                                      controller.businessTime["times"]![index]
                                          ["time"] = ["10:00", "24:00"];
                                    }

                                    // RxList 갱신을 위해 refresh 호출
                                    controller.businessTime.refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //휴게 시간
            Obx(
              () => Column(
                children: [
                  ...List.generate(
                    controller.holidayTime["titles"]!.length,
                    (int index) => Container(
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
                            controller.holidayTime["titles"]![index],
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller
                                              .holidayTime["times"]![index]
                                          ["time"][0],
                                      onPress: () {
                                        if (controller.holidayTime["times"]![
                                                index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.businessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][0] = value;
                                            controller.businessTime["times"]![
                                                index]["time"] = copied;
                                          });
                                        }
                                      }))),
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller
                                              .holidayTime["times"]![index]
                                          ["time"][1],
                                      onPress: () {
                                        if (controller.holidayTime["times"]![
                                                index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.businessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][1] = value;
                                            controller.businessTime["times"]![
                                                index]["time"] = copied;
                                          });
                                        }
                                      }))),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => YellowToggleBtn(
                                  width: 100,
                                  title: "24h 운영",
                                  isSelected:
                                      controller.holidayTime["times"]![index]
                                          ["allDay"], // 현재 상태
                                  onTap: () {
                                    // allDay 값 토글
                                    controller.holidayTime["times"]![index]
                                            ["allDay"] =
                                        !controller.holidayTime["times"]![index]
                                            ["allDay"];

                                    // 시간 데이터 업데이트
                                    if (controller.holidayTime["times"]![index]
                                            ["allDay"] ==
                                        true) {
                                      controller.holidayTime["times"]![index]
                                          ["time"] = ["00:00", "24:00"];
                                    } else {
                                      controller.holidayTime["times"]![index]
                                          ["time"] = ["10:00", "24:00"];
                                    }

                                    // RxList 갱신을 위해 refresh 호출
                                    controller.holidayTime.refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ),
          ]))));
    },
  );
}

void showWheelPicker(
    BuildContext context, void Function(String value) onSelectedItemChanged) {
  // 24시간 형식으로 시간 리스트 생성
  final List<String> _items = List.generate(
    25,
    (index) =>
        '${index.toString().padLeft(2, '0')}:00', // 2자리 시간 형식 (예: 00:00, 01:00, ..., 23:00)
  );

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        child: Column(
          children: [
            // 완료 버튼
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 모달 닫기
                    },
                    child: Text(
                      '완료',
                      style: TextStyle(
                          color: CatchmongColors.yellow_main, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Wheel Picker
            Expanded(
              child: CupertinoPicker(
                itemExtent: 50, // 각 아이템 높이
                onSelectedItemChanged: (int index) {
                  // 선택된 값을 출력
                  print('Selected: ${_items[index]}');
                  final selected = _items[index];
                  onSelectedItemChanged(selected);
                },
                children: _items
                    .map((item) => Center(
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 18),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        )
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        )
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
void showReservationSetting(BuildContext context, int partnerId) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값
  final ReservationConteroller controller = Get.find<ReservationConteroller>();
  String getAvailabilityType(String value) {
    switch (value) {
      case "평일":
        return "WEEKDAY";
      case "주말":
        return "WEEKEND";
      case "매일":
        return "DAILY";
      default:
        return "DAILY";
    }
  }

  String getTimeUnit(String value) {
    switch (value) {
      case "30분":
        return "THIRTY_MIN";
      case "1시간":
        return "ONE_HOUR";
      default:
        return "THIRTY_MIN";
    }
  }

  bool validateDateRange(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate) || startDate.isAtSameMomentAs(endDate)) {
      return true;
    } else {
      return false;
    }
  }

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
              onPressed: () async {
                // await controller.postReservationSetting();
                // Get.back();
                if (controller.reservationNameController.text.isEmpty) {
                  Get.snackbar(
                    "알림",
                    "예약 상품명을 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (controller.tableNumTxtController.text.isEmpty) {
                  Get.snackbar(
                    "알림",
                    "테이블 재고를 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (controller.selectedSettingImage.value == null) {
                  Get.snackbar(
                    "알림",
                    "이미지를 선택해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (validateDateRange(controller.selectedStartTime.value,
                    controller.selectedEndTime.value)) {
                  Get.snackbar(
                    "알림",
                    "기간 설정 오류\n시작 날짜가 종료 날짜와 같거나 이후입니다.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else {
                  ReservationSetting reservationSetting = ReservationSetting(
                    partnerId: partnerId,
                    name: controller.reservationNameController.text,
                    description:
                        controller.reservationDescriptionController.text,
                    startTime: controller.selectedStartTime.value,
                    endTime: controller.selectedEndTime.value,
                    availabilityType:
                        getAvailabilityType(controller.selectedDayType.value),
                    timeUnit: getTimeUnit(controller.selectedMinuteType.value),
                    availableTables:
                        int.tryParse(controller.tableNumTxtController.text) ??
                            0,
                    allowedPeople: controller.selectedNumOfPeople.join(","),
                    reservationImage:
                        controller.selectedSettingImage.value == null
                            ? ""
                            : controller.selectedSettingImage.value!.path,
                  );
                  await controller.postCreateReservationSetting(
                      reservationSetting: reservationSetting);
                  controller.reservationNameController.clear();
                  controller.reservationDescriptionController.clear();
                  controller.selectedDayType.value = "평일";
                  controller.selectedStartTime.value = DateTime.now();
                  controller.selectedEndTime.value = DateTime.now();
                  controller.selectedMinuteType.value = "30분";
                  controller.tableNumTxtController.clear();
                  controller.selectedNumOfPeople.clear();
                  controller.selectedSettingImage.value = null;
                  Get.snackbar(
                    "알림",
                    "예약이 등록되었습니다",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.green_line,
                    colorText: Colors.white,
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                }
              },
              title: Text("등록하기"),
            ),
          ),
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
                    Obx(() => CupertinoSwitch(
                          value: controller.isSetting.value, // 현재 스위치 상태
                          onChanged: (bool value) {
                            controller.isSetting.value = value;
                          },
                          activeColor: CatchmongColors.blue1, // 스위치가 켜졌을 때 색상
                        )),
                  ],
                ),
              ),
              Obx(() => controller.isSetting.isTrue
                  ? ReservationRegisterSection(
                      selectedDayType: controller.selectedDayType.value,
                      nameTxtController: controller.reservationNameController,
                      onChangedName: (String value) {
                        if (controller.reservationNameController.text.length >
                            300) {
                          Future.microtask(() {
                            controller.reservationNameController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                      descriptionTxtController:
                          controller.reservationDescriptionController,
                      onChangedDescription: (String value) {
                        if (controller
                                .reservationDescriptionController.text.length >
                            300) {
                          Future.microtask(() {
                            controller.reservationDescriptionController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                      onChangedDayType: (String? value) {
                        if (value != null) {
                          controller.selectedDayType.value = value;
                        }
                      },
                      selectedStartTime: DateFormat('HH:mm')
                          .format(controller.selectedStartTime.value),
                      selectedEndTime: DateFormat('HH:mm')
                          .format(controller.selectedEndTime.value),
                      selectedMinuteType: controller.selectedMinuteType.value,
                      onChangedMinuteType: (String? value) {
                        if (value != null) {
                          controller.selectedMinuteType.value = value;
                        }
                      },
                      selectedNumOfPeople: controller.selectedNumOfPeople,
                      onChangedNumOfPeople: (String value) {
                        controller.selectedNumOfPeople.add(value);
                      },
                      tableNumTxtController: controller.tableNumTxtController,
                      onChangedTableNum: (String value) {
                        controller.tableNumTxtController.text = value;
                      },
                      onImageSelected: (XFile file) {
                        controller.selectedSettingImage.value = File(file.path);
                        print(
                            "선택된 이미지 : ${controller.selectedSettingImage.value}");
                      },
                      onDeleteImg: () {
                        controller.selectedSettingImage.value = null;
                      },
                      image: controller.selectedSettingImage.value,
                      onChangedStartTime: (DateTime value) {
                        controller.selectedStartTime.value = value;
                      },
                      onChangedEndTime: (DateTime value) {
                        controller.selectedEndTime.value = value;
                      },
                    )
                  : Container()),
              Obx(() => controller.reservationSettings.isNotEmpty
                  ? Column(
                      children: [
                        ...List.generate(
                            controller.reservationSettings.length,
                            (int index) => WrittenReservationRegisterSection(
                                  selectedDayType:
                                      controller.selectedDayType.value,
                                  nameTxtController:
                                      controller.reservationNameController,
                                  onChangedName: (String value) {
                                    if (controller.reservationNameController
                                            .text.length >
                                        300) {
                                      Future.microtask(() {
                                        controller.reservationNameController
                                            .value = TextEditingValue(
                                          text: value.substring(0, 300),
                                          selection: TextSelection.collapsed(
                                              offset: 300),
                                        );
                                      });
                                    }
                                  },
                                  descriptionTxtController: controller
                                      .reservationDescriptionController,
                                  onChangedDescription: (String value) {
                                    if (controller
                                            .reservationDescriptionController
                                            .text
                                            .length >
                                        300) {
                                      Future.microtask(() {
                                        controller
                                            .reservationDescriptionController
                                            .value = TextEditingValue(
                                          text: value.substring(0, 300),
                                          selection: TextSelection.collapsed(
                                              offset: 300),
                                        );
                                      });
                                    }
                                  },
                                  onChangedDayType: (String? value) {
                                    if (value != null) {
                                      controller.selectedDayType.value = value;
                                    }
                                  },
                                  selectedStartTime:
                                      "controller.selectedStartTime.value",
                                  selectedEndTime:
                                      "controller.selectedEndTime.value",
                                  selectedMinuteType:
                                      controller.selectedMinuteType.value,
                                  onChangedMinuteType: (String? value) {
                                    if (value != null) {
                                      controller.selectedMinuteType.value =
                                          value;
                                    }
                                  },
                                  selectedNumOfPeople:
                                      controller.selectedNumOfPeople,
                                  onChangedNumOfPeople: (String value) {
                                    controller.selectedNumOfPeople.add(value);
                                  },
                                  tableNumTxtController:
                                      controller.tableNumTxtController,
                                  onChangedTableNum: (String value) {
                                    controller.tableNumTxtController.text =
                                        value;
                                  },
                                  onImageSelected: (XFile file) {
                                    controller.selectedSettingImage.value =
                                        File(file.path);
                                    print(
                                        "선택된 이미지 : ${controller.selectedSettingImage.value}");
                                  },
                                  onDeleteImg: () {
                                    controller.selectedSettingImage.value =
                                        null;
                                  },
                                  image: controller.selectedSettingImage.value,
                                  onChangedStartTime: (String value) {
                                    // controller.selectedStartTime.value = value;
                                  },
                                  onChangedEndTime: (String value) {
                                    // controller.selectedEndTime.value = value;
                                  },
                                  setting:
                                      controller.reservationSettings[index],
                                ))
                      ],
                    )
                  : Container())
            ],
          ))));
    },
  ).then((_) {
    controller.reservationNameController.clear();
    controller.reservationDescriptionController.clear();
    controller.selectedDayType.value = "평일";
    controller.selectedStartTime.value = DateTime.now();
    controller.selectedEndTime.value = DateTime.now();
    controller.selectedMinuteType.value = "30분";
    controller.tableNumTxtController.clear();
    controller.selectedNumOfPeople.clear();
    controller.selectedSettingImage.value = null;
  });
}

//메뉴 등록
void showMenuAdd(BuildContext context, Partner partner) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값
  final Partner2Controller controller = Get.find<Partner2Controller>();
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
              onPressed: () async {
                if (partner.id != null) {
                  await controller.postRegisterMenus(partnerId: partner.id!);
                  Get.snackbar(
                    "알림",
                    "성공적으로 저장되었습니다.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.green_line,
                    colorText: Colors.white,
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                }
              },
              title: Text("저장하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "메뉴 등록",
            onTap: () {
              Partner previewPratner = Partner(
                  name: partner.name,
                  foodType: partner.foodType,
                  category: partner.category,
                  address: partner.address,
                  phone: partner.phone,
                  hasHoliday: partner.hasHoliday,
                  businessTimeConfig: partner.businessTimeConfig,
                  menus: controller.newMenus,
                  amenities: partner.amenities,
                  breakTime: partner.breakTime,
                  businessProofs: partner.businessProofs,
                  businessTime: partner.businessTime,
                  description: partner.description,
                  id: partner.id,
                  latitude: partner.latitude,
                  longitude: partner.longitude,
                  qrCode: partner.qrCode,
                  regionId: partner.regionId,
                  regularHoliday: partner.regularHoliday,
                  reviewCount: partner.reviewCount,
                  reviews: partner.reviews,
                  storePhotos: partner.storePhotos,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now());
              final businessStatus = controller.getBusinessStatus(
                previewPratner.businessTime ?? "",
                previewPratner.breakTime,
                previewPratner.regularHoliday,
              );
              final rating = controller.getRating(previewPratner);
              final replyCount =
                  controller.getReplyCount(previewPratner.reviews?.length ?? 0);
              controller.showSelectedPartner(
                context,
                previewPratner,
                businessStatus,
                rating,
                replyCount,
              );
            },
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
                        Obx(
                          () => controller.menuImg.value == null
                              ? InkWell(
                                  onTap: () async {
                                    print("갤러리 열기");
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? pickedFile =
                                        await picker.pickImage(
                                      source: ImageSource
                                          .gallery, // or ImageSource.camera
                                      maxWidth:
                                          800, // Optional: Resize the image
                                      maxHeight: 800,
                                    );

                                    if (pickedFile != null) {
                                      final newImagePath = pickedFile.path;
                                      controller.menuImg.value =
                                          File(newImagePath);
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/img-plus.svg'),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color: CatchmongColors.gray100,
                                        )),
                                  ),
                                )
                              : PartnerImgCard(
                                  path: controller.menuImg.value!.path,
                                  isLocal: true, // 로컬 이미지 여부 전달
                                  onDelete: () {
                                    // if (controller.editing.value != null) {
                                    //   controller.editing.value =
                                    //       controller.editing.value!.copyWith(
                                    //     images: controller.editing.value!.images!
                                    //       ..removeAt(idx - 1),
                                    //   );
                                    // }
                                    controller.menuImg.value = null;
                                  },
                                  onTab: () {},
                                ),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Obx(
                                          () => DropdownButton<String>(
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            value: controller
                                                .selectedMenuCategory.value,
                                            items: controller.menuCaregories
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
                                              if (newValue != null) {
                                                controller.selectedMenuCategory
                                                    .value = newValue;
                                              }
                                            },
                                          ),
                                        )),
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
                                    BorderTxtField(
                                      controller:
                                          controller.menuNameTxtController,
                                      hintText: "메뉴명을 입력해주세요.",
                                      onChanged: (String value) {
                                        if (controller.menuNameTxtController
                                                .text.length >
                                            300) {
                                          Future.microtask(() {
                                            controller.menuNameTxtController
                                                .value = TextEditingValue(
                                              text: value.substring(0, 300),
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: 300),
                                            );
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ), //메뉴명
                              SizedBox(
                                height: 8,
                              ),
                              //가격
                              BorderTxtField(
                                controller: controller.menuPriceTxtController,
                                hintText: "가격을 입력해주세요.",
                                onChanged: (String value) {
                                  if (controller
                                          .menuPriceTxtController.text.length >
                                      300) {
                                    Future.microtask(() {
                                      controller.menuPriceTxtController.value =
                                          TextEditingValue(
                                        text: value.substring(0, 300),
                                        selection: TextSelection.collapsed(
                                            offset: 300),
                                      );
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  OutlinedBtn(
                      width: width - 40,
                      title: "등록하기",
                      onPress: () {
                        if (controller.menuImg.value == null) {
                          Get.snackbar(
                            "알림",
                            "메뉴 사진을 최소 1장이상 등록 해주세요.",
                            snackPosition: SnackPosition.TOP, // 상단에 표시
                            backgroundColor: CatchmongColors.yellow_main,
                            colorText: CatchmongColors.black,
                            icon: Icon(Icons.check_circle,
                                color: CatchmongColors.black),
                            duration: Duration(seconds: 1),
                            borderRadius: 10,
                            margin: EdgeInsets.all(10),
                          );
                        } else {
                          Menu menu = Menu(
                              partnerId: partner.id!,
                              category: controller.selectedMenuCategory.value,
                              name: controller.menuNameTxtController.text,
                              price: double.tryParse(
                                      controller.menuPriceTxtController.text) ??
                                  0.0,
                              image: controller.menuImg.value!.path,
                              createdAt: DateTime.now());
                          controller.newMenus.add(menu);
                          controller.selectedMenuCategory.value = "메인메뉴";
                          controller.menuNameTxtController.clear();
                          controller.menuPriceTxtController.clear();
                          controller.menuImg.value = null;
                        }
                      })
                ]),
              ),
              //메뉴 리스트 아이템
              Obx(() => Column(
                    children: [
                      ...List.generate(
                          controller.newMenus.length,
                          (int idx) => Container(
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
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color: CatchmongColors.gray,
                                          width: 1,
                                        ), // 외부 테두리
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8), // 이미지를 둥글게 자르기
                                        child: ImgCard(
                                            isLocal: !controller
                                                .newMenus[idx].image
                                                .contains("uploads"),
                                            path: !controller
                                                    .newMenus[idx].image
                                                    .contains("uploads")
                                                ? controller.newMenus[idx].image
                                                : "${controller.baseUrl}/${controller.newMenus[idx].image}"), // 이미지
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            controller.newMenus[idx].category,
                                            style: TextStyle(
                                              color: CatchmongColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            controller.newMenus[idx].name,
                                            style: TextStyle(
                                              color: CatchmongColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            NumberFormat('#,##0', 'en_US')
                                                    .format(controller
                                                        .newMenus[idx].price) +
                                                "원",
                                            style: TextStyle(
                                              color: CatchmongColors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.newMenus.removeAt(idx);
                                        },
                                        child: SvgPicture.asset(
                                            'assets/images/trash.svg'))
                                  ],
                                ),
                              ))
                    ],
                  ))
            ],
          ))));
    },
  ).then((_) {
    controller.selectedMenuCategory.value = "메인메뉴";
    controller.menuNameTxtController.clear();
    controller.menuPriceTxtController.clear();
    controller.menuImg.value = null;
    controller.newMenus.clear();
  });
}

void showStoreEdit(BuildContext context, int partnerId) {
  double width = MediaQuery.of(context).size.width;
  String selectedBusinessType = "선택"; // 업태 기본값
  String selectedCategory = "선택"; // 카테고리 기본값
  String selectedDay = "매 주"; // 정기 휴무일 기본값
  final Partner2Controller controller = Get.find<Partner2Controller>();
  final LoginController loginController = Get.find<LoginController>();
  String _formatPhoneNumber(String input) {
    // 숫자만 추출
    String digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    print("digits>>> $input");
    // 최대 길이 제한: "010-1234-5678" => 13자리
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    // 형식 적용: 010-XXXX-XXXX
    if (digits.length <= 3) {
      return digits; // 3자리 이하
    } else if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}'; // 3-4 형식
    } else {
      return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}'; // 3-4-4 형식
    }
  }

  List<String> _getbusinessTimeTitles(String type) {
    switch (type) {
      case "매일 같아요":
        return ["영업 시간", "영업 시간"];
      case "평일/주말 달라요":
        return ["평일 영업 시간", "주말 영업 시간"];
      case "요일별로 달라요":
        return [
          "월요일 영업 시간",
          "화요일 영업 시간",
          "수요일 영업 시간",
          "목요일 영업 시간",
          "금요일 영업 시간",
          "토요일 영업 시간",
          "일요일 영업 시간"
        ];
      default:
        return ["영업 시간", "영업 시간"];
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      final bTitles =
          _getbusinessTimeTitles(controller.selectedBusinessTimeConfig.value);

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
              onPressed: () async {
                await controller.addEditingPartner();
                // showPreview(context);
                final partner = controller.editing.value;
                if (partner != null) {
                  final businessStatus = controller.getBusinessStatus(
                    partner.businessTime ?? "",
                    partner.breakTime,
                    partner.regularHoliday,
                  );
                  if (partner.storePhotos == null ||
                      partner.storePhotos!.length < 3) {
                    Get.snackbar(
                      "알림",
                      "업체 사진을 최소 3장이상 등록 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.businessProofs == null ||
                      partner.businessProofs!.length < 1) {
                    Get.snackbar(
                      "알림",
                      "증빙서류를 최소 1장이상 등록 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.address.trim() == "") {
                    Get.snackbar(
                      "알림",
                      "주소를 입력 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else if (partner.phone.trim() == "") {
                    Get.snackbar(
                      "알림",
                      "가게 전화번호를 입력 해주세요.",
                      snackPosition: SnackPosition.TOP, // 상단에 표시
                      backgroundColor: CatchmongColors.yellow_main,
                      colorText: CatchmongColors.black,
                      icon: Icon(Icons.check_circle,
                          color: CatchmongColors.black),
                      duration: Duration(seconds: 1),
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                    );
                  } else {
                    controller.showSelectedPartner(
                      context,
                      partner,
                      businessStatus,
                      5.0,
                      "리뷰 0",
                    );
                  }

                  await controller.updatePartner(partnerId: partnerId);
                  // Navigator.pop(context);
                  // /main으로 이동
                  Get.offAllNamed('/main');
                }
              },
              title: Text("수정하기"),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: PreviewAppbar(
            title: "가게 정보 수정",
            onTap: () async {
              await controller.addEditingPartner();
              // showPreview(context);
              final partner = controller.editing.value;
              if (partner != null) {
                final businessStatus = controller.getBusinessStatus(
                  partner.businessTime ?? "",
                  partner.breakTime,
                  partner.regularHoliday,
                );
                if (partner.storePhotos == null ||
                    partner.storePhotos!.length < 3) {
                  Get.snackbar(
                    "알림",
                    "업체 사진을 최소 3장이상 등록 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.businessProofs == null ||
                    partner.businessProofs!.length < 1) {
                  Get.snackbar(
                    "알림",
                    "증빙서류를 최소 1장이상 등록 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.address.trim() == "") {
                  Get.snackbar(
                    "알림",
                    "주소를 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (partner.phone.trim() == "") {
                  Get.snackbar(
                    "알림",
                    "가게 전화번호를 입력 해주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else {
                  controller.showSelectedPartner(
                    context,
                    partner,
                    businessStatus,
                    5.0,
                    "리뷰 0",
                  );
                }
              }
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
                  BorderTxtField(
                    hintText: "가게명을 입력해주세요.",
                    controller: controller.editingPartnerNameTxtController,
                    onChanged: (String value) {
                      if (controller
                              .editingPartnerNameTxtController.text.length >
                          300) {
                        Future.microtask(() {
                          controller.editingPartnerNameTxtController.value =
                              TextEditingValue(
                            text: value.substring(0, 300),
                            selection: TextSelection.collapsed(offset: 300),
                          );
                        });
                      }
                    },
                  )
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
                            child: Obx(
                              () => DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: controller.editingSelectedFoodType.value,
                                items: controller.foodTypes
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
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
                                    controller.editingSelectedFoodType.value =
                                        newValue;
                                  }
                                },
                              ),
                            )),
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
                            child: Obx(
                              () => DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: controller.editingSelectedCategory.value,
                                items: controller.categories
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
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
                                    controller.editingSelectedCategory.value =
                                        newValue;
                                  }
                                },
                              ),
                            )),
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
                  Obx(
                    () => SizedBox(
                      height: 102,
                      child: ListView.builder(
                          itemCount:
                              controller.editingBusinessProofs.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, idx) {
                            if (idx == 0) {
                              return InkWell(
                                onTap: () async {
                                  print("갤러리 열기");
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource
                                        .gallery, // or ImageSource.camera
                                    maxWidth: 800, // Optional: Resize the image
                                    maxHeight: 800,
                                  );

                                  if (pickedFile != null) {
                                    final newImagePath = pickedFile.path;
                                    controller.editingBusinessProofs
                                        .add(pickedFile);
                                  }
                                },
                                child: Container(
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
                                        "사진등록\n(${controller.editingBusinessProofs.length} / 120)",
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
                              );
                            } else {
                              final String? imagePath = controller
                                  .editingBusinessProofs[idx - 1].path;
                              print("imagePath: $imagePath");

                              return PartnerImgCard(
                                path: imagePath,
                                isLocal: true, // 로컬 이미지 여부 전달
                                onDelete: () {
                                  // if (controller.editing.value != null) {
                                  //   controller.editing.value =
                                  //       controller.editing.value!.copyWith(
                                  //     images: controller.editing.value!.images!
                                  //       ..removeAt(idx - 1),
                                  //   );
                                  // }
                                  controller.editingBusinessProofs
                                      .removeAt(idx - 1);
                                },
                                onTab: () {
                                  print("Tapped image at index $idx");
                                },
                              );
                            }
                          }),
                    ),
                  )
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
                  Obx(
                    () => SizedBox(
                      height: 102,
                      child: ListView.builder(
                          itemCount: controller.editingStorePhotos.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, idx) {
                            if (idx == 0) {
                              return InkWell(
                                onTap: () async {
                                  print("갤러리 열기");
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource
                                        .gallery, // or ImageSource.camera
                                    maxWidth: 800, // Optional: Resize the image
                                    maxHeight: 800,
                                  );

                                  if (pickedFile != null) {
                                    final newImagePath = pickedFile.path;
                                    controller.editingStorePhotos
                                        .add(pickedFile);
                                  }
                                },
                                child: Container(
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
                                        "사진등록\n(${controller.editingStorePhotos.length} / 120)",
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
                              );
                            } else {
                              final String? imagePath =
                                  controller.editingStorePhotos[idx - 1].path;
                              print("imagePath: $imagePath");

                              return PartnerImgCard(
                                path: imagePath,
                                isLocal: true, // 로컬 이미지 여부 전달
                                onDelete: () {
                                  // if (controller.editing.value != null) {
                                  //   controller.editing.value =
                                  //       controller.editing.value!.copyWith(
                                  //     images: controller.editing.value!.images!
                                  //       ..removeAt(idx - 1),
                                  //   );
                                  // }

                                  controller.editingStorePhotos
                                      .removeAt(idx - 1);
                                },
                                onTab: () {
                                  print("Tapped image at index $idx");
                                },
                              );
                            }
                          }),
                    ),
                  )
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
                          child: Obx(() => BorderTxtField(
                              readOnly: true,
                              hintText: "우편번호",
                              controller: TextEditingController(
                                  text: controller.editingPostCode.value),
                              onChanged: (String value) {}))),
                      SizedBox(
                        width: 8,
                      ),
                      OutlinedBtn(
                          height: 48,
                          width: 120,
                          title: "우편번호",
                          onPress: () async {
                            DataModel model = await Get.to(
                              () => LocationSearchView(),
                            );
                            // onSearch(model);
                            print("주소 검색 결과>>> ${model.address}");
                            controller.editingPostCode.value = model.zonecode;
                            controller.editingAddress.value = model.address;
                          })
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => BorderTxtField(
                      readOnly: true,
                      hintText: "상세주소",
                      controller: TextEditingController(
                        text: controller.editingAddress.value,
                      ),
                      onChanged: (String value) {}))
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
                  BorderTxtField(
                    controller: controller.editingPhoneTxtController,
                    onChanged: (String value) {
                      String formattedValue = _formatPhoneNumber(value);
                      controller.editingPhoneTxtController.text =
                          formattedValue;
                    },
                  )
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
                      controller: controller.editingDescriptionTxtController,
                      onChanged: (String value) {
                        if (controller
                                .editingDescriptionTxtController.text.length >
                            300) {
                          Future.microtask(() {
                            controller.editingDescriptionTxtController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                      maxLines: null, // 여러 줄 허용
                      expands: true, // TextField가 Container에 꽉 차도록 설정
                      decoration: InputDecoration(
                          hintText: "   소개문구를 작성해주세요.",
                          border: InputBorder.none, // 기본 border 제거
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8)),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: CatchmongColors.gray400,
                      ), // 텍스트 스타일 설정
                    ),
                  ),
                ],
              ),
            ), //편의시설
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
                        ...controller.amenities.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: MediaQuery.of(context).size.width / 3.6,
                                title: data,
                                isSelected: controller.editingSelectedAmenities
                                    .contains(data),
                                onTap: () {
                                  if (controller.editingSelectedAmenities
                                      .contains(data)) {
                                    controller.editingSelectedAmenities
                                        .remove(data);
                                  } else {
                                    controller.editingSelectedAmenities
                                        .add(data);
                                  }
                                },
                              ));
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
                        ...controller.holidays.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: MediaQuery.of(context).size.width / 2.3,
                                title: data,
                                isSelected: data == "있어요"
                                    ? controller.editingHasHoliday.value
                                    : !controller.editingHasHoliday.value,
                                onTap: () {
                                  if (data == "있어요") {
                                    controller.editingHasHoliday.value = true;
                                  } else {
                                    controller.editingHasHoliday.value = false;
                                  }
                                },
                              ));
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
                    child: Obx(() => DropdownButton<String>(
                          isExpanded: true,
                          underline: SizedBox(),
                          value: controller.editingSelectedHolidayWeek.value,
                          items: controller.holidayWeeks
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
                              controller.editingSelectedHolidayWeek.value =
                                  newValue; // 값 업데이트
                            }
                          },
                        )),
                  ),
                  SizedBox(height: 16),

                  // 요일 선택 버튼들
                  Wrap(
                    spacing: 4, // 버튼 사이 간격
                    runSpacing: 4, // 줄바꿈 시 간격
                    children: [
                      ...controller.regularHolidays.map((data) {
                        return Obx(() => YellowToggleBtn(
                              width: 42, // 버튼 너비
                              title: data,
                              isSelected:
                                  controller.editingSelectedRegularHoliday ==
                                      data, // 기본 선택값
                              onTap: () {
                                controller.editingSelectedRegularHoliday.value =
                                    data;
                                // 요일 선택 시 동작 추가
                              },
                            ));
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
                        ...controller.businessTimeConfigs.map((data) {
                          return Obx(() => YellowToggleBtn(
                                width: width / 3.6, // 버튼 너비
                                title: data,
                                isSelected: controller
                                        .editingSelectedBusinessTimeConfig
                                        .value ==
                                    data, // 기본 선택값
                                onTap: () {
                                  controller.editingSelectedBusinessTimeConfig
                                      .value = data;

                                  // 선택된 값에 따라 businessTime 업데이트
                                  if (data == "매일 같아요") {
                                    controller.editingBusinessTime["titles"] = [
                                      "영업 시간"
                                    ];
                                    controller.editingBusinessTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                    controller.editingHolidayTime["titles"] = [
                                      "휴게 시간"
                                    ];
                                    controller.editingHolidayTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                  } else if (data == "평일/주말 달라요") {
                                    controller.editingBusinessTime["titles"] =
                                        ["평일 영업 시간", "주말 영업 시간"].obs;
                                    controller.editingBusinessTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                    controller.editingHolidayTime["titles"] =
                                        ["평일 휴게 시간", "주말 휴게 시간"].obs;
                                    controller.editingHolidayTime["times"] = [
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                      {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    ];
                                  } else {
                                    controller.editingBusinessTime["titles"] = [
                                      "월요일 영업 시간",
                                      "화요일 영업 시간",
                                      "수요일 영업 시간",
                                      "목요일 영업 시간",
                                      "금요일 영업 시간",
                                      "토요일 영업 시간",
                                      "일요일 영업 시간"
                                    ].obs;
                                    controller.editingBusinessTime["times"] =
                                        List.generate(
                                      7,
                                      (index) => {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    );
                                    controller.editingHolidayTime["titles"] = [
                                      "월요일 휴게 시간",
                                      "화요일 휴게 시간",
                                      "수요일 휴게 시간",
                                      "목요일 휴게 시간",
                                      "금요일 휴게 시간",
                                      "토요일 휴게 시간",
                                      "일요일 휴게 시간"
                                    ].obs;
                                    controller.editingHolidayTime["times"] =
                                        List.generate(
                                      7,
                                      (index) => {
                                        "time": ["10:00", "24:00"],
                                        "allDay": false,
                                      },
                                    );
                                  }

                                  // 업데이트 후 UI 반영
                                  controller.editingBusinessTime.refresh();
                                },
                              ));
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  ...List.generate(
                    controller.editingBusinessTime["titles"]!.length,
                    (int index) => Container(
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
                            controller.editingBusinessTime["titles"]![index],
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller.editingBusinessTime[
                                          "times"]![index]["time"][0],
                                      onPress: () {
                                        if (controller.editingBusinessTime[
                                                "times"]![index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.editingBusinessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][0] = value;
                                            controller.editingBusinessTime[
                                                    "times"]![index]["time"] =
                                                copied;
                                          });
                                        }
                                      }))),
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller.editingBusinessTime[
                                          "times"]![index]["time"][1],
                                      onPress: () {
                                        if (controller.isAllDay.isFalse) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.editingBusinessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][1] = value;
                                            controller.editingBusinessTime[
                                                    "times"]![index]["time"] =
                                                copied;
                                          });
                                        }
                                      }))),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => YellowToggleBtn(
                                  width: 100,
                                  title: "24h 운영",
                                  isSelected: controller
                                          .editingBusinessTime["times"]![index]
                                      ["allDay"], // 현재 상태
                                  onTap: () {
                                    // allDay 값 토글
                                    controller.editingBusinessTime["times"]![
                                            index]["allDay"] =
                                        !controller.editingBusinessTime[
                                            "times"]![index]["allDay"];

                                    // 시간 데이터 업데이트
                                    if (controller.editingBusinessTime[
                                            "times"]![index]["allDay"] ==
                                        true) {
                                      controller.editingBusinessTime["times"]![
                                          index]["time"] = ["00:00", "24:00"];
                                    } else {
                                      controller.editingBusinessTime["times"]![
                                          index]["time"] = ["10:00", "24:00"];
                                    }

                                    // RxList 갱신을 위해 refresh 호출
                                    controller.editingBusinessTime.refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //휴게 시간
            Obx(
              () => Column(
                children: [
                  ...List.generate(
                    controller.editingHolidayTime["titles"]!.length,
                    (int index) => Container(
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
                            controller.editingHolidayTime["titles"]![index],
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller.editingHolidayTime[
                                          "times"]![index]["time"][0],
                                      onPress: () {
                                        if (controller.editingHolidayTime[
                                                "times"]![index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.editingBusinessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][0] = value;
                                            controller.editingBusinessTime[
                                                    "times"]![index]["time"] =
                                                copied;
                                          });
                                        }
                                      }))),
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
                                  child: Obx(() => OutlinedBtn(
                                      title: controller.editingHolidayTime[
                                          "times"]![index]["time"][1],
                                      onPress: () {
                                        if (controller.editingHolidayTime[
                                                "times"]![index]["allDay"] ==
                                            false) {
                                          showWheelPicker(context,
                                              (String value) {
                                            final copied = [
                                              ...controller.editingBusinessTime[
                                                  "times"]![index]["time"]
                                            ];
                                            copied[index][1] = value;
                                            controller.editingBusinessTime[
                                                    "times"]![index]["time"] =
                                                copied;
                                          });
                                        }
                                      }))),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => YellowToggleBtn(
                                  width: 100,
                                  title: "24h 운영",
                                  isSelected: controller
                                          .editingHolidayTime["times"]![index]
                                      ["allDay"], // 현재 상태
                                  onTap: () {
                                    // allDay 값 토글
                                    controller
                                            .editingHolidayTime["times"]![index]
                                        ["allDay"] = !controller
                                            .editingHolidayTime["times"]![index]
                                        ["allDay"];

                                    // 시간 데이터 업데이트
                                    if (controller.editingHolidayTime["times"]![
                                            index]["allDay"] ==
                                        true) {
                                      controller.editingHolidayTime["times"]![
                                          index]["time"] = ["00:00", "24:00"];
                                    } else {
                                      controller.editingHolidayTime["times"]![
                                          index]["time"] = ["10:00", "24:00"];
                                    }

                                    // RxList 갱신을 위해 refresh 호출
                                    controller.editingHolidayTime.refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]))));
    },
  );
}
