import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/content/payback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCameraContent extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // QRView의 키
  final PaybackController controller = Get.put(PaybackController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: CatchmongColors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
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
