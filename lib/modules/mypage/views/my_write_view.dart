import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/controller/review_controller.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/card/my_write_card.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWriteView extends StatelessWidget {
  const MyWriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.find<ReviewController>();
    final LoginController loginController = Get.find<LoginController>();
    if (loginController.user.value != null) {
      controller.fetchMyReviews(loginController.user.value!.id);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(title: "내가 쓴 글"),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 16,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text(
                      "내가 쓴 리뷰 ${controller.myReviews.length}개",
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Text(
                  "리뷰 수정 안내",
                  style: TextStyle(
                    color: CatchmongColors.gray400,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ), // 글 리스트
          // MapChip(
          //   title: "주문 후 3일이 지났거나, 차단된 리뷰는 수정할 수 없습니다.",
          //   isActive: false,
          //   marginRight: 0,
          //   leadingIcon: Container(),
          //   useLeadingIcon: false,
          // ),

          // Obx(() =>
          //  controller.isLoading.value
          //     ? Expanded(
          //         child: Center(
          //           child: SizedBox(
          //             width: 40,
          //             child: CircularProgressIndicator(
          //               valueColor: AlwaysStoppedAnimation<Color>(
          //                 CatchmongColors.yellow_main,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     :
          Obx(() => Expanded(
                child: ListView(children: [
                  ListView.builder(
                    itemCount: controller.myReviews.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final review = controller.myReviews[index];
                      return MyWriteCard(
                        baseUrl: controller.baseUrl + "/",
                        review: review,
                        isExpanded: review.isExpanded.value,
                        onExpand: () {
                          controller.myReviews[index] = review.copyWith(
                              isExpanded: !review.isExpanded.value);
                        },
                      );
                    },
                  ),
                ]),
                // )
              )),
          // 최상단에 위치하도록 Positioned로 MapChip 추가
          //지우지 마시오
          // Positioned(
          //   right: 0,
          //   top: 30, // 필요한 위치로 조정
          //   child: MapChip(
          //     title: "주문 후 3일이 지났거나, 차단된 리뷰는 수정할 수 없습니다.",
          //     isActive: false,
          //     marginRight: 0,
          //     leadingIcon: Container(),
          //     useLeadingIcon: false,
          //   ),
          // ),
        ],
      ),
    );
  }
}
