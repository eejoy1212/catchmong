import 'dart:async';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void goLocation() {
    Timer(Duration(seconds: 2), () {
      print("5초 지나면 location 페이지로 갑니다");
      Get.offAndToNamed('/location');
    });
  }
}
