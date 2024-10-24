import 'package:catchmong/modules/location/scrap/controllers/scrap_controller.dart';
import 'package:get/get.dart';

class ScrapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScrapController>(() => ScrapController());
  }
}
