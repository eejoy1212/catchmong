import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/InfoBtn.dart';
import 'package:flutter/material.dart';

class CloseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CloseAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: const AppbarBackBtn(),
      actions: [
        CloseButton(
          color: CatchmongColors.black,
        )
      ],
      centerTitle: true,
      title: Text(
        title,
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
