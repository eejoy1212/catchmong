import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/content/scrap_partner_content.dart';
import 'package:catchmong/widget/content/scrap_store_content.dart';
import 'package:flutter/material.dart';

class ScrapView extends StatelessWidget {
  const ScrapView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: CatchmongColors.gray50,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: const AppbarBackBtn(),
            centerTitle: true,
            title: const Text(
              "스크랩",
              style: TextStyle(
                  color: CatchmongColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            // bottom: const TabBar(
            //   tabs: [
            //     Tab(text: "파트너"),
            //     Tab(text: "스토어"),
            //   ],
            //   indicator: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Colors.black, // 디바이더 색상 설정
            //         width: 2.0, // 디바이더 두께 설정
            //       ),
            //     ),
            //   ),
            //   indicatorSize: TabBarIndicatorSize.tab, // 탭 전체에 꽉 차게
            //   labelColor: CatchmongColors.black, // 선택된 탭의 글자 색상
            //   unselectedLabelColor: CatchmongColors.gray400, // 선택되지 않은 탭의 글자 색상
            //   labelStyle: TextStyle(
            //     fontSize: 16, // 선택된 탭 글자 크기 설정 (16px)
            //     fontWeight: FontWeight.w400, // 선택된 탭 글자를 볼드 처리
            //   ),
            //   unselectedLabelStyle: const TextStyle(
            //       fontSize: 16, // 선택되지 않은 탭 글자 크기 설정 (16px)
            //       fontWeight: FontWeight.w400, // 선택된 탭 글자를 볼드 처리
            //       color: CatchmongColors.gray400),
            // ),
          ),
          body: // 파트너 탭
              ScrapPartnerContent(),
          // TabBarView(
          //   children: [
          //     // 파트너 탭
          //     ScrapPartnerContent(),
          //     // 스토어 탭
          //     ScrapStoreContent(),
          //   ],
          // ),
        ));
  }
}
