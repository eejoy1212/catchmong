import 'package:catchmong/modules/loading/controllers/loading_controller.dart';
import 'package:get/get.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}
