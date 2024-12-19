import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PaybackController extends GetxController {
  // var result = Rxn<String>(); // QR 코드 결과를 저장
  QRViewController? qrController;

  // QRView 생성 시 호출되는 메서드
  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    qrController!.scannedDataStream.listen((scanData) {
      result.value = scanData.code; // 결과 업데이트
    });
  }

  var result = RxnString(); // null 값을 허용하는 observable 변수

  void onCodeScanned(String code) {
    result.value = code; // 스캔 결과를 상태에 저장
    // 추가 작업 (예: 서버 전송, UI 업데이트 등)
    Get.snackbar('QR 스캔 완료', '결과: $code', snackPosition: SnackPosition.BOTTOM);
  }

  // 카메라 제어 메서드 추가
  void pauseCamera() {
    qrController?.pauseCamera();
  }

  void resumeCamera() {
    qrController?.resumeCamera();
  }

  @override
  void onClose() {
    qrController?.dispose(); // 리소스 정리
    super.onClose();
  }
}
