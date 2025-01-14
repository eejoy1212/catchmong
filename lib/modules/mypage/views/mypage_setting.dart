import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MypageSetting extends StatelessWidget {
  final LoginController controller = LoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackBtn(),
        centerTitle: true,
        title: const Text(
          "설정",
          style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed('/signup');
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
                      "프로필 설정",
                      style: TextStyle(
                        color: CatchmongColors.sub_gray,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset('assets/images/right-arrow.png')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed('/alarm');
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
                      "알림 설정",
                      style: TextStyle(
                        color: CatchmongColors.sub_gray,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset('assets/images/right-arrow.png')
                  ],
                ),
              ),
            ),
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
                      "회원탈퇴",
                      style: TextStyle(
                        color: CatchmongColors.sub_gray,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset('assets/images/right-arrow.png')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.logout();
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
                      "로그아웃",
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
      )),
    );
  }
}
