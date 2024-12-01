import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/alarm/controllers/alarm_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // CupertinoSwitch를 위한 임포트
import 'package:get/get.dart';

class AlarmSettingView extends StatelessWidget {
  const AlarmSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    // 컨트롤러 인스턴스 생성
    final AlarmController controller = Get.find<AlarmController>();

    return Scaffold(
      backgroundColor: CatchmongColors.gray50,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  // Get.toNamed('/alarm-setting');
                },
                child: Image.asset('assets/images/setting-icon.png')),
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
      ),
      body: Center(
        child: Column(
          children: [
            // 앱 알림
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 32),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: CatchmongColors.gray50,
                    width: 1,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "앱 알림",
                        style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          "알림을 꺼도 중요 공지 사항은 전송될 수 있어요.",
                          softWrap: true,
                          style: TextStyle(
                            color: CatchmongColors.gray400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // 오른쪽에 스위치를 배치하기 위해 Spacer 사용
                  Obx(
                    () => CupertinoSwitch(
                      value:
                          controller.isNotificationEnabled.value, // 현재 스위치 상태
                      onChanged: (bool value) {
                        controller.isNotificationEnabled.value =
                            value; // 상태 업데이트
                      },
                      activeColor: CatchmongColors.blue1, // 스위치가 켜졌을 때 색상
                    ),
                  ),
                ],
              ),
            ),
            // 혜택/이벤트 알림
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 32),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: CatchmongColors.gray50,
                    width: 1,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "혜택/이벤트 알림",
                        style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          "특가,상품, 이벤트 등의 정보를 가장 먼저 받아볼 수 있어요.",
                          softWrap: true,
                          style: TextStyle(
                            color: CatchmongColors.gray400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // 오른쪽에 스위치를 배치하기 위해 Spacer 사용
                  Obx(
                    () => CupertinoSwitch(
                      value:
                          controller.isBonusAndEventEnabled.value, // 현재 스위치 상태
                      onChanged: (bool value) {
                        controller.isBonusAndEventEnabled.value =
                            value; // 상태 업데이트
                      },
                      activeColor: CatchmongColors.blue1, // 스위치가 켜졌을 때 색상
                    ),
                  ),
                ],
              ),
            )
            // 야간 알림
            ,
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 32),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: CatchmongColors.gray50,
                    width: 1,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "야간 알림",
                        style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          "오후 9시 ~ 오전 8시에 발송되는 혜택 알림까지 놓치지 않고 받아볼 수 있어요.",
                          softWrap: true,
                          style: TextStyle(
                            color: CatchmongColors.gray400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // 오른쪽에 스위치를 배치하기 위해 Spacer 사용
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.isNightEnabled.value, // 현재 스위치 상태
                      onChanged: (bool value) {
                        controller.isNightEnabled.value = value; // 상태 업데이트
                      },
                      activeColor: CatchmongColors.blue1, // 스위치가 켜졌을 때 색상
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
