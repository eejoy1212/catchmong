import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/review.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/chip/TagChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final bool isScraped;
  const ReviewCard({Key? key, required this.review, required this.isScraped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String profileBaseUrl = 'http://192.168.200.102:3000';
    String baseUrl = 'http://192.168.200.102:3000/';
    String formatDate(DateTime date) {
      return DateFormat('yyyy.MM.dd').format(date); // 원하는 형식 지정
    }

    String formatThousands(num number) {
      String formattedNumber = NumberFormat('#,###').format(number);
      return formattedNumber;
    }

    return Container(
      width: 240, // 카드의 너비
      // height: 412, // 카드의 높이
      margin: const EdgeInsets.only(
          right: 16, top: 12, bottom: 12), // 카드 간의 간격을 위해 오른쪽 마진 설정
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A의 그림자 (투명한 검정)
            offset: Offset(0, 4), // x축 0, y축 4로 그림자 위치 설정
            blurRadius: 12, // 흐림 효과 (blur)
          ),
        ],
        borderRadius: BorderRadius.circular(12), // 둥근 모서리 반지름 12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 아바타 이미지
                ClipOval(
                  child: Container(
                    width: 36, // 아바타 너비 36px
                    height: 36, // 아바타 높이 36px
                    child: ImgCard(
                        path: profileBaseUrl + (review.user?.picture ?? '')),
                  ),
                ),
                SizedBox(width: 8), // 아바타와 텍스트 사이의 간격
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user?.name ?? '', // 사용자 이름
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CatchmongColors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "작성일",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_300),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          formatDate(review.createdAt),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CatchmongColors.gray_300),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 여기에 프로필 이미지 경로로 이미지를 넣음
          Stack(children: [
            Container(
              height: 240,
              width: double.infinity,
              child: ImgCard(path: baseUrl + (review.images?[0] ?? '')),
            ),
            Positioned(
              left: 20,
              bottom: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/thumbs-up.png"),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    review.title ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      review.content ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.partner?.name ?? '',
                      style: TextStyle(
                          color: CatchmongColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/review-star.svg'),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          review.rating.toString(),
                          style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '(${formatThousands(review.partner!.reviewCount ?? 0)})',
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                SvgPicture.asset(
                    'assets/images/${isScraped ? "scraped" : "no-scraped"}.svg')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                TagChip(label: "#다이닝바"),
                SizedBox(
                  width: 4,
                ),
                TagChip(label: "#논현"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
