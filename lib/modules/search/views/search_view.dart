import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/content/partner_content.dart';
import 'package:catchmong/widget/content/store_content.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // 파트너와 스토어 두 개의 탭
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackBtn(),
          centerTitle: true,
          title: const Text(
            "검색",
            style: TextStyle(
                color: CatchmongColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: PartnerContent(),
      ),
    );
  }
}
