import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/widget/bar/close_appbar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyPurchaseView extends StatelessWidget {
  const MyPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final MypageController controller = MypageController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppbarBackBtn(),
        centerTitle: true,
        title: const Text(
          "구매 내역",
          style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // 작성 가능한 리뷰
          Container(
            margin: EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => MapChip(
                    title: "작성 가능한 리뷰",
                    isActive: controller.isAvailableReview.value,
                    marginRight: 0,
                    leadingIcon: Container(),
                    useLeadingIcon: false,
                    onTap: controller.onToggleReview,
                  ),
                ),
                Obx(
                  () => Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "총",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CatchmongColors.sub_gray,
                          ),
                        ),
                        TextSpan(
                          text: controller.isAvailableReview.isTrue
                              ? " 5"
                              : " 3,104",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: CatchmongColors.gray_800,
                          ),
                        ),
                        TextSpan(
                          text: "개",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CatchmongColors.sub_gray,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          // 가게명 카드 (리스트뷰)
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  height: 230,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 이미지
                      Container(
                        width: 105,
                        height: 181,
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
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "24.10.22 08:00 결제",
                              style: TextStyle(
                                color: CatchmongColors.gray400,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                              "가게 소개를 적어주세요. 3줄 이상 작성시 말줄임표 나오게 해주세요.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                color: CatchmongColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                index == 0
                                    ? Expanded(
                                        child: OutlinedBtn(
                                          title: "방문후기",
                                          fontSize: 14,
                                          onPress: () {
                                            showReviewWrite(context);
                                          },
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: index == 0 ? 8 : 0,
                                ),
                                Expanded(
                                  child: YellowElevationBtn(
                                      onPressed: () {},
                                      title: Text(
                                        "재방문",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Image.asset('assets/images/close-icon.png'))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showReviewWrite(BuildContext context) {
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
