import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
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
          isLogin ? "프로필 수정" : "회원가입",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CatchmongColors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: isLogin
                ? loginController.checkUpdateUserAndGoVerti
                : loginController.checkAndGoVerti,
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
                          child: Obx(() {
                            if (isLogin) {
                              //회원수정 시
                              final imageFile =
                                  loginController.selectedImage.value;
                              bool hasPicture =
                                  loginController.user.value!.picture != null;
                              return imageFile == null || imageFile.path == ""
                                  //기존에 이미지가 있는 상태에서 수정 하는 거
                                  ? hasPicture
                                      ? Image.network(
                                          "${loginController.baseUrl}${loginController.user.value!.picture}", // 로컬 기본 이미지
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/default-profile.png', // 로컬 기본 이미지
                                          fit: BoxFit.cover,
                                        )
                                  //새로 선택하는거
                                  : Image.file(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    );
                            } else {
                              //회원가입 시
                              final imageFile =
                                  loginController.selectedImage.value;
                              return imageFile == null || imageFile.path == ""
                                  ? Image.asset(
                                      'assets/images/default-profile.png', // 로컬 기본 이미지
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    );
                            }
                          }),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () async {
                            await loginController.pickImage(); // 갤러리에서 이미지 선택
                          },
                          child: Image.asset('assets/images/photo-icon.png'),
                        ),
                      ),
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
                  Obx(
                    () => BorderTxtField(
                      controller: loginController.nicknameController,
                      errorText: loginController.nicknameErrTxt.value == ""
                          ? null
                          : loginController.nicknameErrTxt.value,
                      onChanged: (String value) {
                        if (loginController.nicknameController.text.length >
                            300) {
                          Future.microtask(() {
                            loginController.nicknameController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                    ),
                  )
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Obx(
                        () => BorderTxtField(
                          // maxLength: 13,
                          errorText: loginController.phoneErrTxt.value == ""
                              ? null
                              : loginController.phoneErrTxt.value,
                          textInputType: TextInputType.phone,
                          controller: loginController.phoneController,
                          onChanged: (String value) {
                            String formattedValue = _formatPhoneNumber(value);
                            loginController.phoneController.text =
                                formattedValue;
                          },
                        ),
                      )),
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
                        child: Obx(() => YellowToggleBtn(
                              title: "남성",
                              isSelected: loginController.gender.value == "남성",
                              onTap: () {
                                loginController.gender.value = "남성";
                              },
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => YellowToggleBtn(
                              title: "여성",
                              isSelected: loginController.gender.value == "여성",
                              onTap: () {
                                loginController.gender.value = "여성";
                                print(
                                    "현재 선택된 성별: ${loginController.gender.value}");
                              },
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => YellowToggleBtn(
                              title: "비공개",
                              isSelected: loginController.gender.value == "비공개",
                              onTap: () {
                                loginController.gender.value = "비공개";
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 연령
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
                        "연령",
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
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...["10대", "20대", "30대", "40대", "50대", "60대", "70대+"]
                            .map((ageGroup) {
                          return Obx(() => YellowToggleBtn(
                                width: MediaQuery.of(context).size.width / 5,
                                title: ageGroup,
                                isSelected:
                                    loginController.ageGroup.value == ageGroup,
                                onTap: () {
                                  loginController.ageGroup.value = ageGroup;
                                },
                              ));
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 계좌번호
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
                        "페이백 계좌번호",
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
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        OutlinedBtn(width: 100, title: "신한은행", onPress: () {}),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: BorderTxtField(
                              controller: TextEditingController(),
                              onChanged: (String value) {}),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    child: OutlinedBtn(
                        width: MediaQuery.of(context).size.width / 4.5,
                        title: "재인증",
                        onPress: () {}),
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
                          child: Obx(
                        () => YellowToggleBtn(
                          title: "바로바로 받기",
                          isSelected:
                              loginController.paybackMethod.value == "바로바로 받기",
                          onTap: () {
                            loginController.paybackMethod.value = "바로바로 받기";
                          },
                        ),
                      )),
                      SizedBox(width: 16),
                      Expanded(
                          child: Obx(
                        () => YellowToggleBtn(
                          title: "월말에 받기",
                          isSelected:
                              loginController.paybackMethod.value == "월말에 받기",
                          onTap: () {
                            loginController.paybackMethod.value = "월말에 받기";
                          },
                        ),
                      )),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "추천인",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      SvgPicture.asset("assets/images/question-circle.svg"),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => BorderTxtField(
                      errorText:
                          loginController.referrerNicknameErrTxt.value == ""
                              ? null
                              : loginController.referrerNicknameErrTxt.value,
                      controller: loginController.referrerNicknameController,
                      onChanged: (String value) {
                        if (loginController
                                .referrerNicknameController.text.length >
                            300) {
                          Future.microtask(() {
                            loginController.referrerNicknameController.value =
                                TextEditingValue(
                              text: value.substring(0, 300),
                              selection: TextSelection.collapsed(offset: 300),
                            );
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 200,
            ),
          ],
        ),
      )),
    );
  }

  // 번호 입력값 포맷팅 함수
  String _formatPhoneNumber(String input) {
    // 숫자만 추출
    String digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    print("digits>>> $input");
    // 최대 길이 제한: "010-1234-5678" => 13자리
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    // 형식 적용: 010-XXXX-XXXX
    if (digits.length <= 3) {
      return digits; // 3자리 이하
    } else if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}'; // 3-4 형식
    } else {
      return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}'; // 3-4-4 형식
    }
  }
}
