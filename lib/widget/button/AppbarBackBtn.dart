import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarBackBtn extends StatelessWidget {
  final void Function()? onTap;
  const AppbarBackBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(); // onTap이 전달된 경우 실행
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
          });
        }
      },
      child: Icon(
        Icons.arrow_back_ios_rounded,
        size: 16,
        color: CatchmongColors.black,
      ),
    );
  }
}
