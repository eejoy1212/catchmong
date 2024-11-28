import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: const AppbarBackBtn(),
        title: const Text(
          "프로필 수정",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CatchmongColors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/certi');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "저장",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: CatchmongColors.gray400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // 프로필 이미지 구간
            Container(
              margin: EdgeInsets.only(
                top: 16,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 60, // 아바타 너비 60px
                          height: 60, // 아바타 높이 60px
                          child: Image.asset(
                            'assets/images/profile2.jpg',
                            fit: BoxFit.cover, // 이미지가 원형 안에 잘 맞도록 설정
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                              onTap: () {
                                print("이미지 교체 버튼");
                              },
                              child:
                                  Image.asset('assets/images/photo-icon.png')))
                    ],
                  ),
                ],
              ),
            ),
            // 닉네임
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "닉네임",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  BorderTxtField(
                    controller: TextEditingController(),
                    onChanged: (String) {},
                  ),
                ],
              ),
            ),
            // 휴대폰 번호
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 8,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "휴대폰 번호",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BorderTxtField(
                          controller: TextEditingController(),
                          onChanged: (String) {},
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedBtn(
                        title: "변경하기",
                        width: 120,
                        height: 48,
                        fontSize: 14,
                        onPress: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 성별
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 8,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "성별",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: YellowToggleBtn(
                          title: "남성",
                          isSelected: true,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: YellowToggleBtn(
                          title: "여성",
                          isSelected: false,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: YellowToggleBtn(
                          title: "비공개",
                          isSelected: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 페이백
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 8,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "페이백",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: YellowToggleBtn(
                          title: "바로바로 받기",
                          isSelected: true,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: YellowToggleBtn(
                          title: "월말에 받기",
                          isSelected: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 추천인
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "추천인",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  BorderTxtField(
                    controller: TextEditingController(),
                    onChanged: (String) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
