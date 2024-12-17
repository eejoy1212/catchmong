import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/alarm/views/alarm_setting_view.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/content/activity_content.dart';
import 'package:catchmong/widget/content/alarm_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlarmView extends StatelessWidget {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 탭의 개수 설정
      child: Scaffold(
        backgroundColor: CatchmongColors.gray50,
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    // Get.toNamed('/alarm-setting');
                    showAlarmSetting(context);
                  },
                  child: SvgPicture.asset('assets/images/setting-icon.svg')),
            )
          ],
          leading: const AppbarBackBtn(),
          centerTitle: true,
          title: const Text(
            "알림",
            style: TextStyle(
                color: CatchmongColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "공지"),
              Tab(text: "활동"),
            ],
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, // 디바이더 색상 설정
                  width: 2.0, // 디바이더 두께 설정
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab, // 탭 전체에 꽉 차게
            labelColor: CatchmongColors.black, // 선택된 탭의 글자 색상
            unselectedLabelColor: CatchmongColors.gray400, // 선택되지 않은 탭의 글자 색상
            labelStyle: TextStyle(
              fontSize: 16, // 선택된 탭 글자 크기 설정 (16px)
              fontWeight: FontWeight.w400, // 선택된 탭 글자를 볼드 처리
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16, // 선택되지 않은 탭 글자 크기 설정 (16px)
              fontWeight: FontWeight.w400, // 선택되지 않은 탭 글자 스타일
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // 알람 탭 내용
            AlarmContent(),
            // 스토어 탭 내용
            AcitivityContent()
          ],
        ),
      ),
    );
  }
}

void showAlarmSetting(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return AlarmSettingView();
    },
  );
}
