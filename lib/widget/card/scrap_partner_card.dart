import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScrapPartnerCard extends StatelessWidget {
  final Partner partner;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry scrapIconMargin;
  const ScrapPartnerCard({
    super.key,
    this.padding = const EdgeInsets.only(
      top: 16,
      left: 20,
      bottom: 20,
    ),
    this.scrapIconMargin = const EdgeInsets.only(right: 20),
    required this.partner,
  });

  @override
  Widget build(BuildContext context) {
    final Partner2Controller partnerController = Get.find<Partner2Controller>();

    double width = MediaQuery.of(context).size.width;
    final businessStatus = partnerController.getBusinessStatus(
      partner.businessTime ?? "",
      partner.breakTime,
      partner.regularHoliday,
    );

    print("현재 상태: $businessStatus");

    return Container(
      // height: 328,
      padding: padding,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: CatchmongColors.gray50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: scrapIconMargin,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            StarStatus(
                              rating: partnerController.getRating(partner),
                            )
                          ],
                        ),
                        //영업중
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              // width: 100,
                              child: Text(
                                businessStatus,
                                style: TextStyle(
                                  color: businessStatus == "영업중"
                                      ? Colors.green
                                      : businessStatus == "브레이크타임"
                                          ? Colors.orange
                                          : Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                              child: Center(
                                child: Text(
                                  "•",
                                  style: TextStyle(
                                    color: CatchmongColors.sub_gray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              partner.category,
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // 넘칠 경우 ellipsis 처리
                            ),
                            SizedBox(
                              width: 8,
                              child: Center(
                                child: Text(
                                  "•",
                                  style: TextStyle(
                                    color: CatchmongColors.sub_gray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                partnerController.getReplyCount(
                                    partner.reviews?.length ?? 0),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: CatchmongColors.sub_gray,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width * 0.7,
                              // 최대 폭 지정
                              child: Text(
                                partner.address,
                                style: TextStyle(
                                  color: CatchmongColors.sub_gray,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                                // 넘칠 경우 ellipsis 처리
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color: CatchmongColors.sub_gray,
                            )
                          ],
                        )
                      ],
                    ),
                    //pin 뱃지
                    SvgPicture.asset(
                      'assets/images/scraped.svg',
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              // 가로로 슬라이드 가능한 이미지들

              Container(
                height: 156,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: partner.storePhotos == null
                      ? 0
                      : partner.storePhotos?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Get.toNamed('/partner-show');

                        partnerController.selectedPartner.value = partner;
                        if (partnerController.selectedPartner.value != null) {
                          partnerController.showSelectedPartner(
                              context,
                              partner,
                              businessStatus,
                              partnerController.getRating(partner),
                              partnerController
                                  .getReplyCount(partner.reviews?.length ?? 0));
                          partnerController.addLatestPartners(partner.id);
                        }
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
                            child: Image.network(
                              'http://192.168.200.102:3000/${partner.storePhotos?[index]}', // 이미지 경로
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
                height: partner.reviews == null
                    ? 0
                    : partner.reviews!.isEmpty
                        ? 0
                        : 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      partner.reviews == null ? 0 : partner.reviews?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFAFAFD),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      margin: EdgeInsets.only(right: 12),
                      constraints: BoxConstraints(
                        maxWidth: 300, // 최대 너비를 356으로 제한
                      ),
                      // width: 356, // 글자 너비 제한
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        partner.reviews?[index].content ?? "",
                        maxLines: 2, // 최대 줄 수를 2줄로 제한
                        overflow: TextOverflow.ellipsis, // 글자가 넘칠 경우 '...' 표시
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
