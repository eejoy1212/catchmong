import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/bar/CatchmongSearchBar.dart';
import 'package:catchmong/widget/chip/TagChip.dart';
import 'package:flutter/material.dart';

class StoreContent extends StatelessWidget {
  const StoreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
            // height: 600, // 테스트용 길이
            child: Column(
              children: [
                const CatchmongSearchBar(),
                const SizedBox(
                  height: 16,
                ),
                //최근 검색어
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "최근 검색어",
                          style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
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
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 68, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                      child: ListView.builder(
                        itemCount: 10, // 예시로 10개의 항목 생성
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 12, right: 8),
                            margin: const EdgeInsets.only(
                                bottom: 16, top: 16, right: 16),
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: CatchmongColors.gray,
                                )),
                            child: InkWell(
                              onTap: () {
                                print("칩 클릭");
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '맥캘란 12년',
                                      style: TextStyle(
                                          color: CatchmongColors.gray400,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Image.asset('assets/images/chip-close.png')
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      thickness: 1,
                      color: CatchmongColors.gray50,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //최근 본 상품
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "최근 본 상품",
                          style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
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
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 203, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                      child: ListView.builder(
                        itemCount: 10, // 예시로 10개의 항목 생성
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(right: 16),
                              height: 192,
                              child: Column(
                                children: [
                                  // 이미지
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8), // 둥근 모서리로 잘라줌
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
                                  const SizedBox(height: 8), // 이미지와 텍스트 사이 간격
                                  // 가게명
                                  Container(
                                    width: 108, // 부모 컨테이너의 너비를 지정
                                    child: const Text(
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
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      thickness: 1,
                      color: CatchmongColors.gray50,
                    )
                  ],
                ), //인기 상품
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "인기 상품",
                          style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
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
                    const SizedBox(
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
                                const SizedBox(
                                  height: 8,
                                ),
                                // 가게명
                                const SizedBox(
                                  width: 150, // 부모 컨테이너의 너비를 지정
                                  child: Text(
                                    "가게명을 입력해주세요 3줄 이상 작성 시 aaaaaaaaaaaaaaaabbbbbbbccccccccccc",
                                    maxLines: 3, // 최대 3줄까지 표시
                                    overflow:
                                        TextOverflow.ellipsis, // 글자가 넘치면 ... 처리
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: CatchmongColors.gray_800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
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
    );
  }
}
