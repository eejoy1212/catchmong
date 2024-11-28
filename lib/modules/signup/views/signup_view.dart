import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:catchmong/widget/txtfield/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

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
        actions: [
          InkWell(
            onTap: () {
              controller.postAdditionalInfo();
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
                          child: Obx(() {
                            final imageFile = controller.selectedImage.value;
                            return imageFile != null
                                ? Image.file(
                                    imageFile,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/profile2.jpg', // 로컬 기본 이미지
                                    fit: BoxFit.cover,
                                  );
                          }),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () async {
                            await controller.pickImage(); // 갤러리에서 이미지 선택
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
                  BorderTxtField(
                    controller: controller.nicknameController,
                    onChanged: (String value) {
                      if (controller.nicknameController.text.length > 300) {
                        Future.microtask(() {
                          controller.nicknameController.value =
                              TextEditingValue(
                            text: value.substring(0, 300),
                            selection: TextSelection.collapsed(offset: 300),
                          );
                        });
                      }
                    },
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
                        child: TestBorderTxtField(
                          // maxLength: 13,
                          textInputType: TextInputType.phone,
                          controller: controller.phoneController,
                          onChanged: (String value) {
                            String formattedValue = _formatPhoneNumber(value);
                            controller.phoneController.text = formattedValue;
                          },
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
                        child: Obx(() => YellowToggleBtn(
                              title: "남성",
                              isSelected: controller.gender.value == "남성",
                              onTap: () {
                                controller.gender.value = "남성";
                                print("현재 선택된 성별: ${controller.gender.value}");
                              },
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => YellowToggleBtn(
                              title: "여성",
                              isSelected: controller.gender.value == "여성",
                              onTap: () {
                                controller.gender.value = "여성";
                                print("현재 선택된 성별: ${controller.gender.value}");
                              },
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => YellowToggleBtn(
                              title: "비공개",
                              isSelected: controller.gender.value == "비공개",
                              onTap: () {
                                controller.gender.value = "비공개";
                                print("현재 선택된 성별: ${controller.gender.value}");
                              },
                            )),
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
                          child: Obx(
                        () => YellowToggleBtn(
                          title: "바로바로 받기",
                          isSelected:
                              controller.paybackMethod.value == "바로바로 받기",
                          onTap: () {
                            controller.paybackMethod.value = "바로바로 받기";
                          },
                        ),
                      )),
                      SizedBox(width: 16),
                      Expanded(
                          child: Obx(
                        () => YellowToggleBtn(
                          title: "월말에 받기",
                          isSelected:
                              controller.paybackMethod.value == "월말에 받기",
                          onTap: () {
                            controller.paybackMethod.value = "월말에 받기";
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
                    controller: controller.referrerNicknameController,
                    onChanged: (String value) {
                      if (controller.referrerNicknameController.text.length >
                          300) {
                        Future.microtask(() {
                          controller.referrerNicknameController.value =
                              TextEditingValue(
                            text: value.substring(0, 300),
                            selection: TextSelection.collapsed(offset: 300),
                          );
                        });
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
