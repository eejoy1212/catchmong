import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/content/payback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCameraContent extends StatelessWidget {
  final PaybackController controller = Get.find<PaybackController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: (barcode) {
                // final String? code = barcode.; // QR 코드 값 가져오기
                // if (code != null) {
                //   // 중복 스캔 방지
                //   if (controller.result.value != code) {
                //     controller.onCodeScanned(code); // 스캔 처리 메서드 호출
                //   }
                // }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(() => Center(
                  child: controller.result.value != null
                      ? Text('스캔 결과: ${controller.result.value}')
                      : Text('스캔 대기 중...'),
                )),
          ),
        ],
      ),
    );
  }
}
