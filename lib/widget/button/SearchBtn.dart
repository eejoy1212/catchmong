import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/search/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchBtn extends StatelessWidget {
  SearchBtn({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showSearch(context);
        },
        child: SvgPicture.asset('assets/images/search-icon.svg'));
  }
}

void showSearch(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return SearchView();
    },
  );
}
