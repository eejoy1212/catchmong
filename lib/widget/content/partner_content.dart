import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/bar/CatchmongSearchBar.dart';
import 'package:catchmong/widget/chip/TagChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PartnerContent extends StatelessWidget {
  const PartnerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              // height: 600, // 테스트용 길이
              child: Column(
                children: [
                  CatchmongSearchBar(),
                  SizedBox(
                    height: 16,
                  ),
                  //최근 검색어
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "최근 검색어",
                            style: TextStyle(
                                color: CatchmongColors.gray_800,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "전체삭제",
                              style: TextStyle(
                                  color: CatchmongColors.gray400,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      )
                      //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                      // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                      ,
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 100, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                        child: ListView.builder(
                          itemCount: 10, // 예시로 10개의 항목 생성

                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: 28,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '검색어 $index',
                                    style: TextStyle(
                                        color: CatchmongColors.gray_800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 1,
                        color: CatchmongColors.gray50,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //최근 본 매장
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "최근 본 매장",
                            style: TextStyle(
                                color: CatchmongColors.gray_800,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "더보기",
                              style: TextStyle(
                                  color: CatchmongColors.gray400,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      )
                      //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                      // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                      ,
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 203, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                        child: ListView.builder(
                          itemCount: 10, // 예시로 10개의 항목 생성
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 192,
                                child: Column(
                                  children: [
                                    // 이미지
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          8), // 둥근 모서리로 잘라줌
                                      child: Container(
                                        width: 108,
                                        height: 132,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: CatchmongColors.gray,
                                              width: 1), // 외부 테두리
                                        ),
                                        child: Image.asset(
                                          'assets/images/review2.jpg', // 이미지 경로
                                          fit: BoxFit
                                              .cover, // 이미지가 Container 크기에 맞게 자르기
                                        ),
                                      ),
                                    ),
                                    //가게명
                                    SizedBox(height: 8), // 이미지와 텍스트 사이 간격
                                    // 가게명
                                    Container(
                                      width: 108, // 부모 컨테이너의 너비를 지정
                                      child: Text(
                                        "가게명을 입력해주세요 3줄 이상 작성 시 aaaaaaaaaaaaaaaa",
                                        maxLines: 3, // 최대 3줄까지 표시
                                        overflow: TextOverflow
                                            .ellipsis, // 글자가 넘치면 ... 처리
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CatchmongColors.gray_800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 1,
                        color: CatchmongColors.gray50,
                      )
                    ],
                  ), //인기 매장
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "인기 매장",
                            style: TextStyle(
                                color: CatchmongColors.gray_800,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "더보기",
                              style: TextStyle(
                                  color: CatchmongColors.gray400,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      )
                      //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                      // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                      ,
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 263, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                        child: ListView.builder(
                          itemCount: 10, // 예시로 10개의 항목 생성

                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: Column(
                                children: [
                                  // 이미지
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8), // 둥근 모서리로 잘라줌
                                    child: Container(
                                      width: 150,
                                      height: 181,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CatchmongColors.gray,
                                            width: 1), // 외부 테두리
                                      ),
                                      child: Image.asset(
                                        'assets/images/review2.jpg', // 이미지 경로
                                        fit: BoxFit
                                            .cover, // 이미지가 Container 크기에 맞게 자르기
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  // 가게명
                                  SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "가게명",
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
                                                SvgPicture.asset(
                                                    'assets/images/review-star.svg'),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '5.0',
                                                  style: TextStyle(
                                                      color: CatchmongColors
                                                          .gray_800,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '(1,000)',
                                                  style: TextStyle(
                                                      color: CatchmongColors
                                                          .gray_300,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/pin.svg'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      TagChip(label: "#다이닝바"),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      TagChip(label: "#논현"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 1,
                        color: CatchmongColors.gray50,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/banner_payback.png')
          ],
        ),
      ),
    );
  }
}
