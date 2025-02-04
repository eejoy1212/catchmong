import 'dart:async';
import 'package:get/get.dart';

class MypageController extends GetxController {
  // 이미지 표시 여부를 관리하는 반응형 변수
  var showLatestLoginImage = true.obs;
  RxInt myPageToggle = RxInt(0);
  RxBool isAvailableReview = RxBool(false);
  @override
  void onInit() {
    super.onInit();

    // 5초 후에 이미지 표시를 중단합니다.
    Timer(Duration(seconds: 5), () {
      showLatestLoginImage.value = false;
    });
  }

  void onToggleReview() {
    if (isAvailableReview.value) {
      isAvailableReview.value = false;
    } else {
      isAvailableReview.value = true;
    }
  }
}
