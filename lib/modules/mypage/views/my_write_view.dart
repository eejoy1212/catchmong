import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/controller/review_controller.dart';
import 'package:catchmong/model/review.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/bar/close_appbar.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/my_write_card.dart';
import 'package:catchmong/widget/card/partner_img_card.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';

class MyWriteView extends StatelessWidget {
  const MyWriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.find<ReviewController>();
    final LoginController loginController = Get.find<LoginController>();

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
                        onTapEdit: () async {
                          controller.editing.value =
                              controller.myReviews[index];
                          if (controller.editing.value != null) {
                            showEdit(context);
                          }
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

void showEdit(
  BuildContext context,
) {
  final LoginController loginController = Get.find<LoginController>();
  final ReviewController controller = Get.find<ReviewController>();
  double width = MediaQuery.of(context).size.width;
  List<Widget> getStars(double rating) {
    // 결과를 담을 리스트
    List<Widget> stars = [];

    // 정수 부분과 소수 부분 분리
    int fullStars = rating.floor(); // 정수 부분 (1단위 별 개수)
    bool hasHalfStar = (rating - fullStars) >= 0.5; // .5 단위인지 확인

    // 정수 부분에 해당하는 별 추가
    for (int i = 0; i < fullStars; i++) {
      stars.add(SvgPicture.asset('assets/images/star-big.svg'));
    }

    // 소수 부분이 .5일 경우 반 별 추가
    if (hasHalfStar) {
      stars.add(SvgPicture.asset('assets/images/star-big-half.svg'));
    }

    return stars;
  }

  final stars = getStars(controller.editing.value!.rating);
  String generateOrderNumber(DateTime createdAt) {
    return 'ORD-${createdAt.year}${createdAt.month.toString().padLeft(2, '0')}${createdAt.day.toString().padLeft(2, '0')}${createdAt.hour.toString().padLeft(2, '0')}${createdAt.minute.toString().padLeft(2, '0')}${createdAt.second.toString().padLeft(2, '0')}';
  }

  final orderNum = generateOrderNumber(controller.editing.value!.createdAt);
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
              if (controller.editing.value == null) {
                //등록하기
              } else {
                //수정하기
                final editing = controller.editing.value!;
                if (editing.images == null) {
                  Get.snackbar(
                    "알림",
                    "이미지를 3개 이상 선택 해 주세요.",
                    snackPosition: SnackPosition.TOP, // 상단에 표시
                    backgroundColor: CatchmongColors.yellow_main,
                    colorText: CatchmongColors.black,
                    icon:
                        Icon(Icons.check_circle, color: CatchmongColors.black),
                    duration: Duration(seconds: 1),
                    borderRadius: 10,
                    margin: EdgeInsets.all(10),
                  );
                } else if (editing.images!.length < 3) {
                  Get.snackbar(
                    "알림",
                    "이미지를 3개 이상 선택 해 주세요.",
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
                  final res = await controller.updateReview(
                      reviewId: editing.id,
                      userId: editing.userId,
                      rating: editing.rating,
                      content: editing.content,
                      removedImages: controller.removeImages,
                      newImages: editing.images == null
                          ? []
                          : editing.images!
                              .where((path) => !path.contains("uploads"))
                              .map((el) => File(el))
                              .toList());
                  if (res) {
                    if (loginController.user.value != null) {
                      controller.fetchMyReviews(loginController.user.value!.id);
                      controller.removeImages.clear();
                      Get.back();
                      Get.snackbar(
                        "알림",
                        "내가 쓴 리뷰를 수정 완료했습니다.",
                        snackPosition: SnackPosition.TOP, // 상단에 표시
                        backgroundColor: CatchmongColors.yellow_main,
                        colorText: CatchmongColors.black,
                        icon: Icon(Icons.check_circle,
                            color: CatchmongColors.black),
                        duration: Duration(seconds: 1),
                        borderRadius: 10,
                        margin: EdgeInsets.all(10),
                      );
                    }
                  }
                }
              }
            },
            title: Text(controller.editing.value == null ? "등록하기" : "수정하기"),
          ),
        ),
        backgroundColor: CatchmongColors.gray50,
        appBar: CloseAppbar(title: "후기 수정"),
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
                        DateFormat("yyyy.MM.DD HH:MM:SS")
                            .format(controller.editing.value!.createdAt),
                        style: TextStyle(
                          color: CatchmongColors.gray400,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "주문번호 $orderNum",
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
                          child: ImgCard(
                              path:
                                  "${controller.baseUrl}/${controller.editing.value!.partner!.storePhotos![0]}"),
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
                            controller.editing.value!.partner!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: CatchmongColors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: width - 132,
                            child: Text(
                              controller.editing.value!.partner!.description ??
                                  "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: CatchmongColors.gray_800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: EdgeInsets.symmetric(
                          //         vertical: 4,
                          //         horizontal: 8,
                          //       ),
                          //       decoration: BoxDecoration(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(
                          //             20,
                          //           )),
                          //           border: Border.all(
                          //             color: CatchmongColors.gray,
                          //           )),
                          //       child: Center(
                          //         child: Text(
                          //           "수량",
                          //           style: TextStyle(
                          //             fontSize: 10,
                          //             fontWeight: FontWeight.w400,
                          //             color: CatchmongColors.gray400,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 4,
                          //     ),
                          //     Text(
                          //       "|",
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //         color: CatchmongColors.gray400,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 4,
                          //     ),
                          //     Text(
                          //       "1개",
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //         color: CatchmongColors.gray_800,
                          //       ),
                          //     ),
                          //   ],
                          // )
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
                      //별 슬라이드 할 수 있는 라이브러리로 넣기
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: getStars(controller.editing.value!.rating),
                      // ),
                      Obx(() => AnimatedRatingStars(
                            initialRating: controller.editing.value == null
                                ? 0
                                : controller.editing.value!.rating,
                            onChanged: (double rating) {
                              // setState(() {
                              //   _rating = rating;
                              // });
                              if (controller.editing.value != null) {
                                controller.editing.value = controller
                                    .editing.value!
                                    .copyWith(rating: rating);
                              }
                            },
                            maxRating: 5,
                            minRating: 0,
                            displayRatingValue:
                                true, // Display the rating value
                            interactiveTooltips:
                                true, // Allow toggling half-star state
                            customFilledIcon: Icons.star,
                            customHalfFilledIcon: Icons.star_half,
                            customEmptyIcon: Icons.star_border,
                            starSize: 40.0,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            animationCurve: Curves.easeInOut,
                          )),
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
                          controller: TextEditingController(
                              text: controller.editing.value!.content),
                          onChanged: (value) {
                            if (controller.editing.value != null) {
                              controller.editing.value =
                                  controller.editing.value!.copyWith(
                                content: value,
                              );
                            }
                          },
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
                      Obx(
                        () => SizedBox(
                          height: 102,
                          child: ListView.builder(
                            itemCount:
                                (controller.editing.value?.images?.length ??
                                        0) +
                                    1, // +1 for add button
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
                                      maxWidth:
                                          800, // Optional: Resize the image
                                      maxHeight: 800,
                                    );

                                    if (pickedFile != null) {
                                      final newImagePath = pickedFile.path;
                                      if (controller.editing.value != null) {
                                        controller.editing.value =
                                            controller.editing.value!.copyWith(
                                          images: [
                                            ...(controller
                                                    .editing.value?.images ??
                                                []),
                                            newImagePath,
                                          ],
                                        );
                                      }
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
                                          "사진등록\n(${controller.editing.value?.images?.length ?? 0} / 120)",
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
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                final String? imagePath = idx - 1 <
                                        (controller.editing.value?.images
                                                ?.length ??
                                            0)
                                    ? "${controller.editing.value?.images![idx - 1]}"
                                    : "";
                                print("imagePath: $imagePath");
                                final bool isLocal = imagePath != null &&
                                    !imagePath.contains('uploads');
                                print("isLocal: $isLocal");
                                if (isLocal) {
                                  print("Local image path: $imagePath");
                                }
                                return PartnerImgCard(
                                  path: isLocal
                                      ? imagePath
                                      : "${controller.baseUrl}/$imagePath",
                                  isLocal: isLocal, // 로컬 이미지 여부 전달
                                  onDelete: () {
                                    if (controller.editing.value != null) {
                                      if (controller
                                          .editing.value!.images![idx - 1]
                                          .contains("uploads/")) {
                                        controller.removeImages.add(controller
                                            .editing.value!.images![idx - 1]
                                            .split("uploads/")[1]);
                                      }

                                      controller.editing.value =
                                          controller.editing.value!.copyWith(
                                        images:
                                            controller.editing.value!.images!
                                              ..removeAt(idx - 1),
                                      );
                                    }
                                  },
                                  onTab: () {
                                    print("Tapped image at index $idx");
                                  },
                                );
                              }
                            },
                          ),
                        ),
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
