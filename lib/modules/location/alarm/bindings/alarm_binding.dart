import 'package:catchmong/modules/location/alarm/controllers/alarm_controller.dart';
import 'package:get/get.dart';

class AlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlarmController>(() => AlarmController());
  }
}
