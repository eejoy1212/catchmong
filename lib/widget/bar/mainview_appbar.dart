import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/widget/button/AlarmBtn.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/SearchBtn.dart';
import 'package:catchmong/widget/button/ShoppingBtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  MainViewAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
          Get.toNamed('/location-add');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "모든지역",
              style: TextStyle(
                  color: CatchmongColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: CatchmongColors.black,
            )
          ],
        ),
      ),
      actions: [
        SearchBtn(),
        SizedBox(
          width: 16,
        ),
        AlarmBtn(),
        SizedBox(
          width: 16,
        ),
        ShoppingBtn(),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar 높이 + TabBar 높이
}
