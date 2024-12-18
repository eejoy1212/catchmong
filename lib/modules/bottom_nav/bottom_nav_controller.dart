import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  RxBool isShowingPartner = false.obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
