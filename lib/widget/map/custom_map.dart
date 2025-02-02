// import 'dart:io';

// import 'package:catchmong/const/catchmong_colors.dart';
// import 'package:catchmong/controller/partner_controller.dart';
// import 'package:catchmong/modules/login/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:get/get.dart';
// import 'package:catchmong/modules/location/controllers/location_controller.dart';

// class CustomMap extends StatelessWidget {
//   final NLatLng currentPosition;

//   CustomMap({Key? key, required this.currentPosition}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final LocationController controller = Get.find<LocationController>();
//     final Partner2Controller partnerController = Get.find<Partner2Controller>();

//     return NaverMap(
//       options: NaverMapViewOptions(
//         initialCameraPosition: NCameraPosition(
//           target: currentPosition,
//           zoom: 15,
//         ),
//       ),
//       onMapReady: (naverMapController) async {
//         // Fetch and add markers when map is ready
//         //아래는 커스텀이 안됨
//         // naverMapController
//         //     .setLocationTrackingMode(NLocationTrackingMode.follow);
//         naverMapController.clearOverlays();

//         List<NCircleOverlay> markers =
//             await partnerController.fetchNearbyPartners();

//         naverMapController.addOverlayAll(markers.toSet());
//       },
//       // markers: controller.markers,
//     );
//   }
// }
import 'dart:ui';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class CustomMap extends StatelessWidget {
  final NLatLng currentPosition;
  final NaverMapViewOptions options;
  final void Function(NaverMapController) onMapReady;
  final void Function(NCameraUpdateReason, bool) onCameraChange;
  final void Function() onCameraIdle;
  CustomMap(
      {Key? key,
      required this.currentPosition,
      required this.onMapReady,
      required this.options,
      required this.onCameraChange,
      required this.onCameraIdle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: options,
      onCameraChange: onCameraChange,
      onCameraIdle: onCameraIdle,
      onMapTapped: (point, latLng) {
        print(
            "지도 변경 latitude : ${latLng.latitude} / longitude : ${latLng.longitude}");
      },
      onMapReady: onMapReady,
    );
  }

  // 🔹 마커 클릭 시 정보 표시하는 BottomSheet
  // void showPartnerInfo(BuildContext context, dynamic partner) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Container(
  //         padding: EdgeInsets.all(16),
  //         height: 200,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               partner["name"] ?? "가게 이름 없음",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               "📍 주소: ${partner["address"] ?? "주소 정보 없음"}",
  //               style: TextStyle(fontSize: 14),
  //             ),
  //             SizedBox(height: 5),
  //             Text(
  //               "📞 전화번호: ${partner["phone"] ?? "전화번호 없음"}",
  //               style: TextStyle(fontSize: 14),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
