import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxBool isError = RxBool(false);
  RxString errorMessage = RxString("");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
