import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CertiView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    bool isLogin = loginController.user.value != null;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: const AppbarBackBtn(),
        title: Text(
          loginController.user.value == null ? "회원가입" : "휴대폰 번호 변경",
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
                    child: BorderTxtField(
                      readOnly: true,
                      controller: loginController.phoneController,
                      onChanged: (String) {},
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedBtn(
                    title: "인증번호 전송",
                    width: 120,
                    height: 48,
                    fontSize: 14,
                    onPress: loginController.postSendVerti,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BorderTxtField(
                      readOnly: true,
                      suffix: Obx(() {
                        // 남은 시간을 분:초 형식으로 표시
                        int minutes =
                            loginController.remainingSeconds.value ~/ 60;
                        int seconds =
                            loginController.remainingSeconds.value % 60;
                        return Text(
                          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 14,
                            color: CatchmongColors.blue1,
                          ),
                        );
                      }),
                      helper: InkWell(
                        onTap: loginController.postSendVerti,
                        child: Text(
                          "인증번호 재발송",
                          style: TextStyle(
                            color: CatchmongColors.red,
                            fontSize: 10,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      controller: loginController.vertiCodeController,
                      onChanged: (String) {},
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedBtn(
                    title: "인증하기",
                    width: 120,
                    height: 48,
                    fontSize: 14,
                    onPress: () async {
                      await loginController.verifyCode(); // 인증번호 검증
                      if (loginController.isVerified.value) {
                        bool res = isLogin
                            ? // 회원정보 수정시->인증 성공 시 추가 정보 전송
                            await loginController.updateUserInfo(
                                userId: loginController
                                    .user.value!.id, // 수정할 사용자 ID
                                newNickname:
                                    loginController.nicknameController.text,
                                newPhone: loginController.phoneController.text,
                                newGender: loginController.gender.value,
                                newAgeGroup: loginController.ageGroup.value,
                                newPaybackMethod:
                                    loginController.paybackMethod.value,
                                newReferrerNickname: loginController
                                    .referrerNicknameController.text,
                                pictureFile: loginController
                                    .selectedImage.value, // 선택적으로 이미지 파일
                              )
                            : // 가입시->인증 성공 시 추가 정보 전송
                            await loginController.postAdditionalInfo();
                        res
                            ? showConfirmDialog(context, isLogin)
                            : showNoConfirmDialog(context);
                      }
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

void showConfirmDialog(BuildContext context, bool isLogin) {
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
                  isLogin ? Get.toNamed('/main') : Get.toNamed("/loading");
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
