import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapPartnerCard extends StatelessWidget {
  final Partner partner;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry scrapIconMargin;
  const ScrapPartnerCard(
      {super.key,
      this.padding = const EdgeInsets.only(
        top: 16,
        left: 20,
        bottom: 20,
      ),
      this.scrapIconMargin = const EdgeInsets.only(right: 20),
      required this.partner});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 328,
      padding: padding,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: CatchmongColors.gray50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                margin: scrapIconMargin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //글자들
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //가게명
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partner.name,
                              style: TextStyle(
                                color: CatchmongColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            StarStatus()
                          ],
                        ),
                        //영업중
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "영업중",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "•",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "한식",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "•",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "리뷰 999+",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "•",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "서울 강남구 청담동",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Image.asset("assets/images/downward-arrow.png"),
                          ],
                        ),
                      ],
                    ),
                    //pin 뱃지
                    Image.asset('assets/images/pin.png')
                  ],
                ),
              ),
              SizedBox(height: 10),
              // 가로로 슬라이드 가능한 이미지들

              Container(
                height: 156,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
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
                            width: 116,
                            height: 156,
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
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 356, // 글자 너비 제한
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면고객리뷰를 적어주세요 2줄까지 노출 가능하며 더 길어지면",
                        maxLines: 2, // 최대 줄 수를 2줄로 제한
                        overflow: TextOverflow.ellipsis, // 글자가 넘칠 경우 '...' 표시
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
