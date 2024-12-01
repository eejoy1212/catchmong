import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/loading/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoadingController loadingController = Get.find<LoadingController>();
    loadingController.goLocation();
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/loading-mong-logo.png',
                  // width: 360,
                ),
              ),
              Container(
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
                    "assets/images/main-banner1.png",
                    width: MediaQuery.of(context).size.width,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
