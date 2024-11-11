import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapContent extends StatelessWidget {
  MapContent({super.key});

  // 마커 위치 설정 (예: 서울 시청 위치)
  // final NLatLng markerPosition = NLatLng(37.5665, 126.9780); // 고정된 마커 위치

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(child: Text("data")
          //     NaverMap(
          //   options: const NaverMapViewOptions(
          //     initialCameraPosition: NCameraPosition(
          //       target: NLatLng(37.5665, 126.9780), // 초기 카메라 위치도 동일하게 설정
          //       zoom: 15,
          //     ),
          //   ),
          //   onMapReady: (controller) {
          //     print("네이버 맵 로딩됨!");
          //   },
          // ),
          ),
    );
  }
}
