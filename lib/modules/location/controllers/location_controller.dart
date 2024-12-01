import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxBool isError = RxBool(false);
  RxString errorMessage = RxString("");
  Rxn<DataModel> newLocation = Rxn<DataModel>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setLocation(DataModel newRegion) {
    newLocation.value = newRegion;
  }
}
