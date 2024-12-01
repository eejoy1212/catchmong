import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppbar({super.key});
//임시
  final BottomNavController _controller = Get.find<BottomNavController>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: AppbarBackBtn(
        onTap: () {
          //임시
          _controller.onItemTapped(0);
        },
      ),
      centerTitle: true,
      title: const Text(
        "검색",
        style: TextStyle(
            color: CatchmongColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar 높이 + TabBar 높이
}
