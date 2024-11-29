import 'package:catchmong/modules/main/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // 메인 페이지 관련 의존성 주입 (필요시 추가)
    Get.lazyPut<MainController>(() => MainController());
  }
}
