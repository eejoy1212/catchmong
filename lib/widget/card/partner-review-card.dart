import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/model/review.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/button/more-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PartnerReviewCard extends StatelessWidget {
  final void Function()? onReplyTap;
  final Review review;
  PartnerReviewCard({super.key, this.onReplyTap, required this.review});
  String baseUrl = 'http://192.168.200.102:3000/';
  String profileBaseUrl = 'http://192.168.200.102:3000';
  @override
  Widget build(BuildContext context) {
    print("baseUrl + review.images![0]>>>${baseUrl + review.images![0]}");
    final Partner2Controller partnerController = Get.find<Partner2Controller>();
    String formatDate(DateTime date) {
      return DateFormat('yyyy.MM.dd').format(date); // 원하는 형식 지정
    }

    List<Widget> buildStarRating(double rating) {
      List<Widget> stars = [];

      for (int i = 1; i <= 5; i++) {
        if (rating >= i) {
          stars.add(
              //   SvgPicture.asset(
              //   'assets/images/review-star.svg',
              //   width: 20,
              // )
              Image.asset(
            'assets/images/review-star.png',
          ));
        } else if (rating > i - 1 && rating < i) {
          stars.add(
              //   SvgPicture.asset(
              //   'assets/images/review-star-half.svg',
              //   width: 20,
              // )
              Image.asset(
            'assets/images/review-star-half.png',
          ));
        } else {
          break; // 더 이상 별 추가하지 않음
        }
      }

      return stars;
    }

    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 12,
        bottom: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: 36, // 아바타 너비 36px
                  height: 36, // 아바타 높이 36px
                  //리뷰 쓴 유저의 프로필사진도 가져오는걸로 백앤드 수정
                  child: ImgCard(
                      path: profileBaseUrl + (review.user?.picture ?? '')),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //리뷰
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        review.user == null ? "" : review.user!.name,
                        style: TextStyle(
                          color: CatchmongColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Image.asset(
                        'assets/images/grade3.png',
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "리뷰",
                          style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: review.user == null
                              ? ""
                              : review.user!.totalReviews.toString(),
                          style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: "•",
                          style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: "사진",
                          style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: review.user == null
                              ? ""
                              : review.user!.totalImages.toString(),
                          style: TextStyle(
                              color: CatchmongColors.gray400,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ])),
                      SizedBox(
                        width: 2,
                      ),
                    ],
                  ),
                  //별점
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: buildStarRating(review.rating),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "작성일",
                        style: TextStyle(
                          color: CatchmongColors.gray_300,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        formatDate(review.createdAt),
                        style: TextStyle(
                          color: CatchmongColors.gray_300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                  //  이미지 라는 텍스트가 가로방향으로 슬라이드 되게  열개 배치해줘
                  ,
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: review.images!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed('/partner-show');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(index == 0 ? 8 : 0),
                        bottomLeft: Radius.circular(index == 0 ? 8 : 0),
                        topRight: Radius.circular(index == 29 ? 8 : 0),
                        bottomRight: Radius.circular(index == 29 ? 8 : 0),
                      ),
                      child: Container(
                        width: 200,
                        height: 240,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: CatchmongColors.gray, width: 1), // 외부 테두리
                        ),
                        child: ImgCard(path: baseUrl + review.images![index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(() => Text(
                review.content ?? "",
                maxLines:
                    partnerController.isExpanded.isTrue ? null : 3, // 최대 3줄로 설정
                overflow: partnerController.isExpanded.isTrue
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis, // 4줄부터는 말줄임표로 표시
                style: TextStyle(
                  color: CatchmongColors.sub_gray,
                  fontSize: 14,
                ),
              )),
          SizedBox(
            height: 8,
          ),
          Obx(() => MoreBtn(
                onTap: () {
                  partnerController.isExpanded.value =
                      !partnerController.isExpanded.value;
                },
                isExpanded: partnerController.isExpanded.value,
              )),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: 36, // 아바타 너비 36px
                  height: 36, // 아바타 높이 36px
                  child: Image.asset(
                    'assets/images/profile2.jpg',
                    fit: BoxFit.cover, // 이미지가 원형 안에 잘 맞도록 설정
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: 20,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xFFFAFAFD),
                      border: Border.all(
                        color: CatchmongColors.gray50,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "사장님",
                            style: TextStyle(
                              color: CatchmongColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return SvgPicture.asset(
                                'assets/images/review-star.svg',
                              );
                            }),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "작성일",
                            style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "24.10.11",
                            style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: onReplyTap,
                        child: Text(
                          "리뷰에 대한 답변을 작성해주세요.",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            endIndent: 20,
            color: CatchmongColors.gray50,
          )
        ],
      ),
    );
  }
}
