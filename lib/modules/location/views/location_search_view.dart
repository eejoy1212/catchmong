import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSearchView extends StatelessWidget {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.find<LocationController>();

    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onConsoleMessage: (_, message) => print(message),
      onReceivedError: (webController, request, error) {
        // LocationController의 isError와 errorMessage 업데이트
        controller.isError.value = true;
        controller.errorMessage.value = error.description;
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackBtn(),
        title: Text(
          "주소 검색",
          style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: daumPostcodeSearch,
              ),
              Visibility(
                visible: controller.isError.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(controller.errorMessage.value),
                    ElevatedButton(
                      child: Text("Refresh"),
                      onPressed: () {
                        // 오류 발생 시 새로고침
                        controller.isError.value = false;
                        daumPostcodeSearch.controller?.reload();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
