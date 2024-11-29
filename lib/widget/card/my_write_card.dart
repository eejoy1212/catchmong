import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/more-btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWriteCard extends StatelessWidget {
  const MyWriteCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //가게명,별점 컬럼
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
                          "가게명",
                          style: TextStyle(
                            color: CatchmongColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Image.asset(
                          'assets/images/right-arrow.png',
                        ),
                      ],
                    ),

                    //별점
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Image.asset(
                              'assets/images/review-star.png',
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
                    )
                    //  이미지 라는 텍스트가 가로방향으로 슬라이드 되게  열개 배치해줘
                    ,
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showConfirmDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                          20,
                        )),
                        border: Border.all(
                          color: CatchmongColors.gray,
                        )),
                    child: Center(
                      child: Text(
                        "수정",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    showConfirmDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                          20,
                        )),
                        border: Border.all(
                          color: CatchmongColors.gray,
                        )),
                    child: Center(
                      child: Text(
                        "삭제",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 240,
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
                        width: 200,
                        height: 240,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: CatchmongColors.gray, width: 1), // 외부 테두리
                        ),
                        child: Image.asset(
                          'assets/images/profile3.png', // 이미지 경로
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
            height: 16,
          ),
          Text(
            "리뷰 내용을 작성해주세요.3줄까지 노출가능하며 4줄부터 말줄임표 설정 해주세요.더보기 버튼 클릭 시 전체 리뷰와 사장님 댓글까지 확인 가능합니다.",
            maxLines: 3, // 최대 3줄로 설정
            overflow: TextOverflow.ellipsis, // 4줄부터는 말줄임표로 표시
            style: TextStyle(
              color: CatchmongColors.sub_gray,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          MoreBtn(),
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
                              return Image.asset(
                                'assets/images/review-star.png',
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
                      Text(
                        "리뷰에 대한 답변을 작성해주세요.",
                        style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontSize: 14,
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

void showConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Text(
                  "리뷰를 삭제하시면 재작성이 불가능합니다.\n 삭제하시겠습니까?",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: CatchmongColors.gray_300))),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1, // 버튼 사이의 구분선
                      height: 60,
                      color: CatchmongColors.gray_300,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // 확인 버튼의 동작 추가
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "확인",
                            style: TextStyle(
                              color: CatchmongColors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
