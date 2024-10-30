import 'package:catchmong/modules/partner/controllers/partner-controller.dart';
import 'package:get/get.dart';

class PartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerController>(() => PartnerController());
  }
}
