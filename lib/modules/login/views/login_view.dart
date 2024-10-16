import 'package:catchmong/widget/button/GoogleBtn.dart';
import 'package:catchmong/widget/button/KakaoBtn.dart';
import 'package:catchmong/widget/button/NaverBtn.dart';
import 'package:catchmong/widget/dialog/UseDialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/login-img.png',
              width: 360,
            ),
            SizedBox(
              width: 360,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/three-second.png',
                    width: 115,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      KakaoBtn(),
                      NaverBtn(),
                      GoogleBtn(),
                    ],
                  ),
                  Obx(() {
                    return Opacity(
                      opacity: controller.showLatestLoginImage.value ? 1 : 0,
                      child: Image.asset(
                        'assets/images/latest-login.png',
                        width: 115,
                      ),
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
