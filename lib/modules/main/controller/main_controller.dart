import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  // final LoginController loginController = Get.find<LoginController>();
  @override
  void onInit() {
    final storage = GetStorage();
    final storedUser = User.fromJson(storage.read('user'));
    // loginController.user.value = storedUser;
    // TODO: implement onInit
    super.onInit();
  }
}
