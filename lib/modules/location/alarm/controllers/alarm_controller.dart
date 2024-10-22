import 'package:get/get.dart';

class AlarmController extends GetxController {
  // 스위치 상태를 관리하는 변수
  RxBool isNotificationEnabled = true.obs;
  RxBool isBonusAndEventEnabled = true.obs;
  RxBool isNightEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
