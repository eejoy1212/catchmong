import 'package:catchmong/modules/mypage/controllers/mypage_controller.dart';
import 'package:catchmong/modules/partner/controllers/partner-controller.dart';
import 'package:get/get.dart';

class MypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MypageController>(() => MypageController());
  }
}
