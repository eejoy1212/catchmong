import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          //내 정보 구간
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: CatchmongColors.gray50,
            ))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //프로필
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
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          "이원희님",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "계정아이디",
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 16,
                ),
                //친추 페이백 버튼
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                        color: CatchmongColors.yellow_main,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: CatchmongColors.yellow_line,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "친구 초대하고 1%페이백 받기",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        Image.asset('assets/images/right-arrow.png')
                      ],
                    ),
                  ),
                ),
                //추천인, 추천인 목록 버튼들
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    //추천인 버튼
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: CatchmongColors.gray100,
                              )),
                          child: Center(
                            child: Text(
                              "내 추천인",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                    //추천인 목록 버튼
                    ,
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: CatchmongColors.gray100,
                              )),
                          child: Center(
                            child: Text(
                              "추천인 목록",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
          //타일 1-스크랩
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "스크랩",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
          //타일 2-내가 쓴 글
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "내가 쓴 글",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
          //타일 3-서비스 이용약관
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "서비스 이용약관",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          ) //타일 4-개인정보 처리방침
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "개인정보 처리방침",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          ) //타일 5-위치정보 이용약관
          ,
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 21,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "위치정보 이용약관",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                    ),
                  ),
                  Image.asset('assets/images/right-arrow.png')
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
