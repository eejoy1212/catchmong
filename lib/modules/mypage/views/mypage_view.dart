import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/widget/dialog/UseDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyPageView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  final MypageController myPageController = MypageController();

  @override
  Widget build(BuildContext context) {
    bool isLogin = loginController.user.value != null;
    print("in mypage user>>>${loginController.user} // $isLogin ");

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${loginController.user.value?.nickname}님",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          loginController.user.value?.email ?? "",
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
                  onTap: () {
                    showShareDialog(context);
                  },
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
                          onTap: () {
                            if (myPageController.myPageToggle.value == 0) {
                              myPageController.myPageToggle.value = 1;
                            } else {
                              myPageController.myPageToggle.value = 0;
                            }
                          },
                          child: Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                    color: CatchmongColors.gray100,
                                  )),
                              child: Center(
                                child: Text(
                                  myPageController.myPageToggle.value == 0
                                      ? "내 추천인"
                                      : loginController
                                              .referrer.value?.nickname ??
                                          "없음",
                                  style: TextStyle(
                                      color: CatchmongColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          )),
                    )
                    //추천인 목록 버튼
                    ,
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showRecommenderDialog(context);
                        },
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
            onTap: () {
              Get.toNamed('/scrap');
            },
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
          //타일 1-내 예약
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/scrap');
            },
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
                    "내 예약",
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
            onTap: () {
              Get.toNamed('/my-write');
            },
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
          //타일 3-구매 내역
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-purchase');
            },
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
                    "구매 내역",
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
//타일 3-내 가게
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-purchase');
            },
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
                    "내 가게",
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
//타일 3-고객센터
          ,
          InkWell(
            onTap: () {
              Get.toNamed('/my-purchase');
            },
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
                    "고객센터",
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

          //타일 4-서비스 이용약관
          ,
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UseDialog();
                  });
            },
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
          ) //타일 5-개인정보 처리방침
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
          ) //타일 6-위치정보 이용약관
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

//추천인 창
void showRecommenderDialog(BuildContext context) {
  final LoginController loginController = Get.find<LoginController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
                opacity: 0, child: Image.asset('assets/images/close-icon.png')),
            Text(
              "추천인 목록",
              style: TextStyle(
                color: CatchmongColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/images/close-icon.png'))
          ],
        ),
        content: SizedBox(
          height: 350,
          child: ListView.builder(
            itemCount: loginController.referreds.length, // 원하는 데이터 개수로 설정
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: CatchmongColors.gray50,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 36, // 아바타 너비 36px
                        height: 36, // 아바타 높이 36px
                        child: Image.asset(
                          index % 2 == 0
                              ? 'assets/images/profile3.png'
                              : 'assets/images/profile1.jpg',
                          fit: BoxFit.cover, // 이미지가 원형 안에 잘 맞도록 설정
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${loginController.referreds[index].nickname}님",
                          style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${loginController.referreds[index].email}",
                          style: TextStyle(
                              color: CatchmongColors.gray_300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

//공유하기 창
void showShareDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
                opacity: 0, child: Image.asset('assets/images/close-icon.png')),
            Text(
              "공유하기",
              style: TextStyle(
                color: CatchmongColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/images/close-icon.png'))
          ],
        ),
        content: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kakao-share.png'),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "카카오로\n공유하기",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                width: 32,
              ),
              InkWell(
                onTap: () {
                  // 클립보드에 "공유링크" 텍스트 복사
                  Clipboard.setData(ClipboardData(text: "공유링크"));
                  Get.back();
                  showShareConfirmDialog(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/link-share.png'),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "링크로\n공유하기",
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void showShareConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Text(
                    "초대 링크가 복사되었습니다.지금 공유해보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              InkWell(
                onTap: () {
                  // 확인 버튼의 동작 추가
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: CatchmongColors.gray_300,
                  ))),
                  height: 60,
                  child: Text(
                    "확인",
                    style: TextStyle(
                      color: CatchmongColors.blue1,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
