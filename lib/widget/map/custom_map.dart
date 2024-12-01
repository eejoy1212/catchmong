import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';

class CustomMap extends StatelessWidget {
  final NLatLng currentPosition;

  CustomMap({Key? key, required this.currentPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.find<LocationController>();

    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: currentPosition,
          zoom: 15,
        ),
      ),
      onMapReady: (naverMapController) async {
        // Fetch and add markers when map is ready
        //아래는 커스텀이 안됨
        // naverMapController
        //     .setLocationTrackingMode(NLocationTrackingMode.follow);
        naverMapController.clearOverlays();

        List<NCircleOverlay> markers = await controller.getNearbyPartners();
        naverMapController.addOverlayAll(markers.toSet());
      },
      // markers: controller.markers,
    );
  }
}
