import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/GoogleBtn.dart';
import 'package:catchmong/widget/button/KakaoBtn.dart';
import 'package:catchmong/widget/button/NaverBtn.dart';
import 'package:catchmong/widget/dialog/UseDialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: SvgPicture.asset(
                "assets/images/login-logo.svg", // 동적으로 아이콘 경로 선택
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                children: [
                  // SvgPicture.asset(
                  //   "assets/images/three-second.svg", // 동적으로 아이콘 경로 선택
                  // ),
                  Image.asset("assets/images/three-second.png"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      KakaoBtn(
                        onTap: () {
                          // Get.offAndToNamed('/signup');
                          // Get.offAndToNamed('/main');
                          controller.loginWithKakao();
                          // controller.kakaoLoginTest();
                        },
                      ),
                      NaverBtn(
                        onTap: () {
                          Get.offAndToNamed('/main');
                        },
                      ),
                      GoogleBtn(
                        onTap: () async {
                          Get.offAndToNamed('/main');
                          // final auth = await controller.handleGoogleSignIn();
                          // if (auth != null) {
                          //   print("토큰..?$auth");
                          // await controller.loginWithGoogle(auth); // 서버 요청
                          // }
                        },
                      ),
                    ],
                  ),
                  Obx(() {
                    return Opacity(
                      opacity: controller.showLatestLoginImage.value ? 1 : 0,
                      // child: SvgPicture.asset(
                      //   "assets/images/latest-login.svg", // 동적으로 아이콘 경로 선택
                      //   colorFilter: ColorFilter.mode(
                      //       CatchmongColors.yellow_main, BlendMode.srcATop),
                      // ),
                      child: Image.asset("assets/images/latest-login.png"),
                    );
                  }),
                  // SizedBox(
                  //   height: 32,
                  // ),
                  Wrap(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "회원가입 없이 소셜 계정을 통해 바로 이용 가능하며 첫 로그인 시 ",
                          style: TextStyle(
                            color: Color(0xFF5e5e5e),
                          ),
                          children: [
                            TextSpan(
                              text: "이용약관",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UseDialog();
                                    },
                                  );
                                },
                            ),
                            TextSpan(
                              text: " 및 ",
                            ),
                            TextSpan(
                              text: "개인정보처리방침",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UseDialog();
                                    },
                                  );
                                },
                            ),
                            TextSpan(
                              text: " 동의로 간주됩니다.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
