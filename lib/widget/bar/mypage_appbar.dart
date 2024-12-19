import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/mypage/views/mypage_setting.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MypageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MypageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: const AppbarBackBtn(),
      centerTitle: true,
      actions: [
        InkWell(
            onTap: () {
              showSetting(context);
            },
            child: SvgPicture.asset('assets/images/appbar-setting.svg')),
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

void showSetting(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return MypageSetting();
    },
  );
}
