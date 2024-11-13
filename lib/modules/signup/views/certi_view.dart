import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CertiView extends StatelessWidget {
  const CertiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: const AppbarBackBtn(),
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CatchmongColors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // 휴대폰 번호
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 8,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: BorderTxtField(text: "휴대폰 번호(- 제외)"),
                  ),
                  SizedBox(width: 10),
                  OutlinedBtn(
                    title: "인증번호 전송",
                    width: 120,
                    height: 48,
                    fontSize: 14,
                    onPress: () {},
                  ),
                ],
              ),
            ),
            // 인증번호 4자리
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 8,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: BorderTxtField(text: "인증번호 4자리"),
                  ),
                  SizedBox(width: 10),
                  OutlinedBtn(
                    title: "인증하기",
                    width: 120,
                    height: 48,
                    fontSize: 14,
                    onPress: () {
                      showConfirmDialog(context);
                      Get.toNamed('/loading');
                    },
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

void showConfirmDialog(BuildContext context) {
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
                    "인증되었습니다.",
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

void showNoConfirmDialog(BuildContext context) {
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
                    "인증번호가 일치하지 않습니다.",
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
