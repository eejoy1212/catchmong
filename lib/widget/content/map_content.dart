// import 'package:catchmong/modules/location/controllers/location_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';

// class MapContent extends StatelessWidget {
//   MapContent({super.key});
//   final LocationController controller = LocationController();
//   // 마커 위치 설정 (예: 서울 시청 위치)
//   final NLatLng markerPosition = NLatLng(37.5665, 126.9780); // 고정된 마커 위치
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         // child: Text("data")
//         child: NaverMap(
// options: const NaverMapViewOptions(
//   initialCameraPosition: NCameraPosition(
//     target: NLatLng(37.5665, 126.9780), // 초기 카메라 위치도 동일하게 설정
//     zoom: 15,
//   ),
// ),
//           onMapReady: (controller) {
//             print("네이버 맵 로딩됨!");
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class MapContent extends StatelessWidget {
  MapContent({super.key});

  final LocationController locationController = LocationController();
  final NaverMapController? _mapController = null;

  // 현재 위치를 가져오는 메서드
  Future<NLatLng> _getCurrentPosition() async {
    // 위치 권한 요청
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition();
    return NLatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: FutureBuilder<NLatLng>(
          future: _getCurrentPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final currentPosition = snapshot.data!;
              final marker = NCircleOverlay(
                id: "marker",
                center: currentPosition,
                radius: 16,
                color: CatchmongColors.green_line,
              );
              //  NMarker(
              //   id: 'currentLocationMarker',
              //   position: currentPosition,

              // );

              return NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: currentPosition, // 초기 카메라 위치도 동일하게 설정
                    zoom: 15,
                  ),
                ),
                onMapReady: (controller) {
                  controller.addOverlay(marker);

                  // 지도 로딩이 완료되면 마커 추가
                  // controller.addMarker(
                  //   Marker(
                  //     markerId: 'currentLocationMarker',
                  //     position: currentPosition,
                  //     captionText: '내 위치',
                  //   ),
                  // );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
