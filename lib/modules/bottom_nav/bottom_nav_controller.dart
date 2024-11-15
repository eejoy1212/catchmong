import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // 현재 선택된 탭의 인덱스
  var selectedIndex = 4.obs;

  // 탭 선택 시 호출되는 메서드
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
