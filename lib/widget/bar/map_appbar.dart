import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/InfoBtn.dart';
import 'package:flutter/material.dart';

class MapAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: const AppbarBackBtn(),
      centerTitle: true,
      title: const Text(
        "지도",
        style: TextStyle(
            color: CatchmongColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      actions: [
        InfoBtn(),
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
