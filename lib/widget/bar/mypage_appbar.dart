import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:flutter/material.dart';

class MypageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MypageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppbarBackBtn(),
      centerTitle: true,
      actions: [
        InkWell(
            onTap: () {
              print("세팅");
            },
            child: Image.asset('assets/images/setting-icon.png')),
        SizedBox(
          width: 20,
        )
      ],
      title: const Text(
        "마이페이지",
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
