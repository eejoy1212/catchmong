import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/loading/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoadingController loadingController = Get.find<LoadingController>();
    // loadingController.goLocation();
    return Scaffold(
      backgroundColor: CatchmongColors.yellow_main,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 160),
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
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width,
                  height: 220, // 카드의 높이와 동일하게 설정
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                      color: CatchmongColors.gray,
                      borderRadius: BorderRadius.all(Radius.circular(
                        24,
                      ))),
                  child: Image.asset(
                    "assets/images/temp-banner.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
