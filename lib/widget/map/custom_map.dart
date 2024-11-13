import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class CustomMap extends StatelessWidget {
  final NLatLng currentPosition;

  CustomMap({Key? key, required this.currentPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marker = NCircleOverlay(
      id: "marker",
      center: currentPosition,
      radius: 16,
      color: CatchmongColors.green_line,
    );

    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: currentPosition,
          zoom: 15,
        ),
      ),
      onMapReady: (controller) {
        controller.addOverlay(marker);
      },
    );
  }
}
