import 'dart:async';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Timer(Duration(seconds: 5), () {
      print("5초 지나면 location 페이지로 갑니다");
      Get.toNamed('/location');
    });
  }
}
