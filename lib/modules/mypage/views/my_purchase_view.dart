import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
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
                                          onPress: () {},
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
